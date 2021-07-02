Class {
	#name : #SSEClient,
	#superclass : #Object,
	#instVars : [
		'url',
		'lastId',
		'retry',
		'client',
		'chunkSize',
		'buffer',
		'connection',
		'close'
	],
	#category : #Oddly
}

{ #category : #'as yet unclassified' }
SSEClient >> accumulateChunks [
	| re chunk split |
	re := '(.*)(\r\n\r\n|\r\r|\n\n)(.*)' asRegex.
	
	[ true ] whileTrue: [		
		chunk := connection next: chunkSize.
		chunk 
			ifNil: [
				" we ran out of chunks before the end, so we reconnect and try again "
				(retry / 1000.0) seconds asDelay wait.
				self connect.
				" we can only resume on a whole message, so discard contents after newline "
				split := buffer splitOn: '\n'.
				buffer := chunk at: 1, '\n'.
			]
			ifNotNil: [
				" if we have a chunk, append it to the buffer "
				buffer := buffer, chunk.
			].
			(re matches: buffer) ifTrue: [	^ re ].
	]
]

{ #category : #accessing }
SSEClient >> client: c [
	client := c.
	client
		headerAt: 'Cache-Control' put: 'no-cache';
		headerAt: 'Accept' put: 'text/event-stream'.
]

{ #category : #accessing }
SSEClient >> close [
	close := true
]

{ #category : #accessing }
SSEClient >> close: boolean [
	close := boolean
]

{ #category : #ssl }
SSEClient >> connect [
	lastId isNotNil ifTrue: [ client headerAt: 'Last-Event-Id' put: lastId ].
	connection := client logToTranscript;
		url: url;
		streaming: true;
		get.


]

{ #category : #initialization }
SSEClient >> initialize [
	retry := 3000.
	chunkSize := 1024.
	buffer := ''.
	close := false.

]

{ #category : #accessing }
SSEClient >> lastId: l [
	lastId := l
]

{ #category : #accessing }
SSEClient >> read [
	| re message |
	
	" We need to accumulate the chunks into a buffer then parse the buffer "
	" the end_of_field regex tells us when we've reached the end. If we "
	" run out of text before then then we need to start over. "
	" We need to accumulate an array of Events somewhere, then hand them over "
	" for json parsing "
	" if end_of_field_regex matches, split the string on end_of_field, otherwise accumulate in buffer"
	" end_of_field could be divided across chunks so we need search for it in the buffer "
	re := self accumulateChunks.
	message := SSEEvent parse: (re subexpression: 2).
	buffer := re subexpression: 4.
	message retry isNotNil ifTrue: [ self retry: (message retry) ].
	message id isNotNil ifTrue: [ self lastId: (message id) ].
	^ message
]

{ #category : #accessing }
SSEClient >> retry: r [
	retry := r
]

{ #category : #accessing }
SSEClient >> url: u [
	url := u
]
