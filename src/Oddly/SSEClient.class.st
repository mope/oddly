Class {
	#name : #SSEClient,
	#superclass : #Object,
	#instVars : [
		'process',
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
	| chunk split |

	chunk := connection next: chunkSize.
	chunk 
		ifNil: [
			" we ran out of chunks before the end, so we reconnect and try again "
			(retry / 1000.0) seconds asDelay wait.
			client get.
			" we can only resume on a whole message, so discard contents after newline "
			split := buffer splitOn: String lf.
			buffer := split at: 1, String lf.
		]
		ifNotNil: [
			" if we have a chunk, append it to the buffer "
			buffer := buffer, chunk.
		].


]

{ #category : #accessing }
SSEClient >> client: c [
	client := c.
	client
		headerAt: 'Cache-Control' put: 'no-cache';
		headerAt: 'Accept' put: 'text/event-stream'.
]

{ #category : #'initialize-release' }
SSEClient >> close [
	process terminate
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
SSEClient >> read: ui [
	| delimiterPosition raw messages |
	
	" FIXME this crashes if you close it before it's accumulated anything. "
	process := [ [ true ] whileTrue: [
		self accumulateChunks.
		" The server could return combinations of lfs and crs, so this is not quite correct "
		delimiterPosition := buffer findString: String lf, String lf.
		(delimiterPosition ~= 0) ifTrue: [
			raw := buffer splitOn: String lf, String lf.
			buffer := raw last.
			messages := raw allButLast collect: [ :line | SSEEvent parse: line ].
			messages last retry isNotNil ifTrue: [ self retry: (messages last retry) ].
			messages last id isNotNil ifTrue: [ self lastId: (messages last id) ].
			messages do: [ :message | ui appendText: message data. ].
		].
	] ] forkAt: Processor userBackgroundPriority.
]

{ #category : #accessing }
SSEClient >> retry: r [
	retry := r
]

{ #category : #accessing }
SSEClient >> url: u [
	url := u
]
