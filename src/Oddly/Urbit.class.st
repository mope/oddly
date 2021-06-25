Class {
	#name : #Urbit,
	#superclass : #Object,
	#instVars : [
		'ui',
		'client',
		'uuid',
		'closed',
		'url',
		'password',
		'ship'
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
	client := ZnClient new timeout: 30.
	url := 'http://localhost:8080/~/'.
	password := 'lidlut-tabwed-pillex-ridrup'.
	ship := 'zod'
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
	| chunk response |
	
	closed := false.
	response := client
 	  logToTranscript;
		url: url, 'channel/', uuid;
		streaming: true;
		get.

	[
		[ closed ] whileFalse: [	
			chunk := response next: 1024.
			ui setText: (chunk utf8Decoded)
		]
	] fork
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
