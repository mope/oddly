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
		at: 'event-id' put: eventId asNumber.
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
	self deleteChannel.
	sseclient close.
	client close
]

{ #category : #ssl }
Urbit >> connect [
	self logIn.
	self subscribe.
	self openChannel
]

{ #category : #'as yet unclassified' }
Urbit >> deleteChannel [
	| message messageArray |
	
	message := Dictionary new
		at: 'id' put: (self actionId);
		at: 'action' put: 'delete';
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
	self read.


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
   " FIXME seem to be getting 403 missing on ack "
	sseclient read: ui.
	"self ack: message id."
	" This doesn't seem to be working "
	" Compare to implementations here: "
	" https://github.com/urbit/urbit/blob/6ed5ccbc4ee833a823163bea1a9db1ae2944f0a3/pkg/arvo/app/landscape/js/channel.js "
	" https://github.com/clonex10100/urbit-api.el/blob/master/urbit-http.el "
	" Am I missing some of the message numbers? Maybe I need to accumulate then send them "
	" ui appendText: (STONJSON fromString: message data) asString. "
	
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
