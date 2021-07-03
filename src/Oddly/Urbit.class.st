Class {
	#name : #Urbit,
	#superclass : #TKTService,
	#instVars : [
		'ui',
		'client',
		'uuid',
		'url',
		'password',
		'ship',
		'sseclient',
		'closed'
	],
	#category : #Oddly
}

{ #category : #'initialize-release' }
Urbit >> close [
	closed := true
]

{ #category : #ssl }
Urbit >> connect [	
	self logIn.
	self subscribe.
	self openChannel
]

{ #category : #initialization }
Urbit >> initialize [
	super initialize.
	url := 'http://localhost:8080/~/'.
	password := 'lidlut-tabwed-pillex-ridrup'.
	ship := 'zod'.
	client := ZnClient new timeout: 30.
	sseclient := SSEClient new client: client.
	closed := false
]

{ #category : #'as yet unclassified' }
Urbit >> logIn [
	client logToTranscript;
	url: url, 'login';
	formAt: 'password' put: password;
	post.
]

{ #category : #accessing }
Urbit >> name [
	^ 'Urbit ship ', ship
]

{ #category : #'as yet unclassified' }
Urbit >> openChannel [
	"closed := false.
	chunkSize := 1024.
	response := client logToTranscript;
		url: url, 'channel/', uuid;
		streaming: true;
		get.

	chunk := response next: chunkSize.
	
	[
		(chunk isNotEmpty) whileTrue: [	
			ui setText: (chunk utf8Decoded).
			chunk := response next: chunkSize.
		]
	] fork"
	sseclient url: url, 'channel/', uuid; connect.
]

{ #category : #'meta-object-protocol' }
Urbit >> read [
	| message |
	message := sseclient read.
	ui setText: (message data).
]

{ #category : #stepping }
Urbit >> stepService [
	1 second wait.
	self read
]

{ #category : #'as yet unclassified' }
Urbit >> subscribe [
	| message messageJson messageArray |
	
	uuid := UUID new asString.
	message := Dictionary new
			at: 'id' put: 1;
			at: 'action' put: 'subscribe';
			at: 'ship' put: ship;
			at: 'app' put: 'graph-store';
			at: 'path' put: '/updates';
			yourself.
	messageArray := Array new: 1.
	messageArray at: 1 put: message.
	messageJson := STONJSON toString: messageArray.
	
	client logToTranscript;
		url: url, 'channel/', uuid;
		entity: (ZnEntity 
  	 		with: messageJson
			type: ZnMimeType applicationJson);
		put.
]

{ #category : #accessing }
Urbit >> ui: instance [
	ui := instance
]
