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
		'connection'
	],
	#category : #Oddly
}

{ #category : #'as yet unclassified' }
SSEClient >> accumulateChunks [
	| chunk split delimiterPosition txt |

	[ connection atEnd ] whileFalse: [	
		chunk := connection next: chunkSize.
		chunk 
			ifNil: [
				" we ran out of chunks before the end, so we reconnect and try again "
				(retry / 1000.0) seconds asDelay wait.
				client get.
				" we can only resume on a whole message, so discard contents after newline "
				split := buffer splitOn: '\n'.
				buffer := split at: 1, '\n'.
			]
			ifNotNil: [
				" if we have a chunk, append it to the buffer "
				buffer := buffer, chunk.
			].
		   " The server could return combinations of lfs and crs, so this is not quite correct "
			delimiterPosition := buffer findString: String lf, String lf.
			(delimiterPosition ~= 0) ifTrue: [ 
      			txt := buffer copyFrom: 1 to: (delimiterPosition - 1).
				buffer := buffer allButFirst: (delimiterPosition + 1).
				^ txt.
			]
	].
	^ ''
]

{ #category : #accessing }
SSEClient >> client: c [
	client := c.
	client
		headerAt: 'Cache-Control' put: 'no-cache';
		headerAt: 'Accept' put: 'text/event-stream'.
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

]

{ #category : #accessing }
SSEClient >> lastId: l [
	lastId := l
]

{ #category : #accessing }
SSEClient >> read [
	| raw message |
	
	" We need to accumulate the chunks into a buffer then parse the buffer "
	" the end_of_field regex tells us when we've reached the end. If we "
	" run out of text before then then we need to start over. "
	" We need to accumulate an array of Events somewhere, then hand them over "
	" for json parsing "
	raw := self accumulateChunks.
	message := SSEEvent parse: (raw).
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
