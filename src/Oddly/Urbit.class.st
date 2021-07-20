Class {
	#name : #Urbit,
	#superclass : #Object,
	#instVars : [
		'client',
		'uuid',
		'url',
		'password',
		'ship',
		'closed',
		'actionId'
	],
	#category : #Oddly
}

{ #category : #'as yet unclassified' }
Urbit >> ack: eventId [
	| message messageArray |
	
	message := Dictionary new
		at: 'id' put: (self actionId);
		at: 'action' put: 'ack';
		at: 'event-id' put: eventId asNumber;
		yourself.
	messageArray := Array new: 1.
	messageArray at: 1 put: message.

	Transcript show: String cr.
	Transcript show: message.
	
	client logToTranscript;
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

{ #category : #'as yet unclassified' }
Urbit >> backlog: resource [
	
	^ self scry: 'graph-store/newest' path: resource, '/', '100' mark: 'json'
]

{ #category : #'as yet unclassified' }
Urbit >> baseHash [
	^ self scry: 'file-server' path: '/clay/base/hash' mark: 'json' 
]

{ #category : #'initialize-release' }
Urbit >> close [
	closed := true.
	self deleteChannel.
	client close
]

{ #category : #ssl }
Urbit >> connect [
	client := self getAuthenticatedClient.

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

{ #category : #'as yet unclassified' }
Urbit >> getAuthenticatedClient [
	| newClient |
	newClient := ZnClient new.
	newClient logToTranscript;
		url: url, 'login';
		formAt: 'password' put: password;
		post.
		
	^ newClient.
]

{ #category : #initialization }
Urbit >> initialize [
	closed := false.
	actionId := 0.
]

{ #category : #accessing }
Urbit >> password: p [
	password := p
]

{ #category : #'as yet unclassified' }
Urbit >> scry: app path: path mark: mark [

	^ client logToTranscript;
		url: url, 'scry/', app, path, '.', mark;
		get;
		response.

]

{ #category : #'as yet unclassified' }
Urbit >> send: ship_ app: app path: path action: action [
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

{ #category : #accessing }
Urbit >> ship: s [
	ship := s
]

{ #category : #accessing }
Urbit >> url: u [
	url := u
]

{ #category : #accessing }
Urbit >> uuid: u [
	uuid := u
]
