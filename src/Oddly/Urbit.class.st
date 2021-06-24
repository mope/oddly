Class {
	#name : #Urbit,
	#superclass : #Object,
	#instVars : [
		'ui'
	],
	#category : #Oddly
}

{ #category : #ssl }
Urbit >> connect [
	| client chunk response uuid |
	uuid := UUID new asString.
	client := ZnClient new timeout: 30.

	client logToTranscript;
		url: 'http://localhost:8080/~/login';
		formAt: 'password' put: 'lidlut-tabwed-pillex-ridrup';
		post.

	client logToTranscript;
		url: 'http://localhost:8080/~/channel/', uuid;
		entity: (ZnEntity 
  	 		with:'[{
		 	  "id": 1,
				"action": "subscribe",
				"ship": "zod",
				"app": "graph-store",
				"path": "/updates"
			}]'
			type: ZnMimeType applicationJson);
		put.
	
	response := client
 	  logToTranscript;
		url: 'http://localhost:8080/~/channel/', uuid;
		streaming: true;
		get.
		
	chunk := response next: 1024.
	ui setText: (chunk utf8Decoded)
	
]

{ #category : #accessing }
Urbit >> ui: instance [
	ui := instance
]
