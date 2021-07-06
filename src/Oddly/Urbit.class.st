Class {
	#name : #Urbit,
	#superclass : #Object,
	#instVars : [
		'ui',
		'client',
		'uuid',
		'url',
		'password',
		'ship',
		'sseclient',
		'closed',
		'actionId'
	],
	#category : #Oddly
}

{ #category : #'as yet unclassified' }
Urbit >> ack: eventId [
	| ackClient message messageArray |
	
	ackClient := ZnClient new.
	message := Dictionary new
		at: 'id' put: (self actionId);
		at: 'action' put: 'ack';
		at: 'event-id' put: eventId.
	messageArray := Array new: 1.
	messageArray at: 1 put: message.
		
	ackClient logToTranscript;
		url: url, 'channel/', uuid;
		entity: (ZnEntity
			with: (STONJSON toString: messageArray)
			type: ZnMimeType applicationJson);
		put.
]

{ #category : #accessing }
Urbit >> actionId [
	actionId := actionId + 1.
	^ actionId
]

{ #category : #'initialize-release' }
Urbit >> close [
	closed := true.
	client close
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
	closed := false.
	actionId := 0.
]

{ #category : #'as yet unclassified' }
Urbit >> logIn [
	client logToTranscript;
	url: url, 'login';
	formAt: 'password' put: password;
	post.
]

{ #category : #'as yet unclassified' }
Urbit >> openChannel [
	sseclient url: url, 'channel/', uuid; connect.
	[ [ closed ] whileFalse: [
		self read.
		Processor yield.  
	] ] forkAt: Processor userBackgroundPriority
]

{ #category : #'as yet unclassified' }
Urbit >> poke: ship_ app: app path: path action: action [
	| message messageArray |
	
	message := Dictionary new
		at: 'id' put: (self actionId);
		at: 'action' put: action;
		at: 'ship' put: ship_;
		at: 'app' put: app;
		at: 'path' put: path;
		yourself.
	messageArray := Array new: 1.
	messageArray at: 1 put: message.

	client logToTranscript;
		url: url, 'channel/', uuid;
		entity: (ZnEntity
			with: (STONJSON toString: messageArray)
			type: ZnMimeType applicationJson);
		put.
]

{ #category : #'meta-object-protocol' }
Urbit >> read [
	| message |
	message := sseclient read.
	self ack: message id.
	" ui appendText: (STONJSON fromString: message data) asString. "
	ui appendText: message data.
]

{ #category : #'as yet unclassified' }
Urbit >> subscribe [
	uuid := UUID new asString.
	self
		poke: ship
		app: 'graph-store'
		path: '/updates'
		action: 'subscribe'.

]

{ #category : #accessing }
Urbit >> ui: instance [
	ui := instance
]
