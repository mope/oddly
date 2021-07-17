Class {
	#name : #Oddly,
	#superclass : #SpApplication,
	#instVars : [
		'ui',
		'urbit',
		'sseclient',
		'storeContainer',
		'metadataStore',
		'graphStore',
		'metadataList',
		'messageHandler'
	],
	#category : #Oddly
}

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
	storeContainer := StoreContainer new
		metadataStore: metadataStore;
		graphStore: graphStore.
	metadataList := MetadataList new
		storeContainer: storeContainer;
		subscribeTo: metadataStore announcer;
		oddly: self;
		title: 'Groups';
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
	messageHandler := MessageHandler new urbit: urbit; storeContainer: storeContainer.
	sseclient := SSEClient new
		client: urbit getAuthenticatedClient;
		messageHandler: messageHandler.
	sseclient url: url, 'channel/', uuid; connect.
	sseclient read.

]

{ #category : #'instance creation' }
Oddly >> newChatWindow: chat [
	ChatWindow new storeContainer: storeContainer;
		resource: chat shortResource;
		subscribeTo: graphStore announcer;
		title: chat title;
		openWithSpec.
	" FIXME there must be a better way of storing the resource "
	storeContainer add: (urbit backlog: ('/~', chat shortResource)) contents.
]
