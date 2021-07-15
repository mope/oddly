Class {
	#name : #Oddly,
	#superclass : #Object,
	#instVars : [
		'ui',
		'urbit',
		'sseclient',
		'messageHandler',
		'metadataStore',
		'graphStore',
		'metadataList'
	],
	#category : #Oddly
}

{ #category : #'as yet unclassified' }
Oddly >> backlog: resource [
	^ urbit backlog: resource
]

{ #category : #'as yet unclassified' }
Oddly >> baseHash [
	^ urbit baseHash
]

{ #category : #'initialize-release' }
Oddly >> close [
	urbit close.
	sseclient close.
]

{ #category : #initialization }
Oddly >> initialize [
	| url password ship uuid |
	metadataStore := MetadataStore new.
	graphStore := GraphStore new.
	messageHandler := MessageHandler new
		metadataStore: metadataStore;
		graphStore: graphStore.
	metadataList := MetadataList new
		metadataStore: metadataStore;
		subscribeTo: metadataStore announcer;
		oddly: self;
		openWithSpec.
	ui := OddlyView new
		graphStore: graphStore;
		subscribeTo: graphStore announcer;
		openWithSpec.
		
	url := 'http://localhost:8080/~/'.
	password := 'lidlut-tabwed-pillex-ridrup'.
	ship := 'zod'.
	uuid := UUID new asString.
	urbit := Urbit new
		url: url;
		password: password;
		ship: ship;
		uuid: uuid;
		connect.
	sseclient := SSEClient new
		client: urbit getAuthenticatedClient;
		messageHandler: messageHandler.
	sseclient url: url, 'channel/', uuid; connect.
	sseclient read.

]
