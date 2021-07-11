Class {
	#name : #Oddly,
	#superclass : #Object,
	#instVars : [
		'ui',
		'urbit',
		'client',
		'sseclient',
		'messageHandler',
		'metadataStore',
		'graphStore',
		'metadataList'
	],
	#category : #Oddly
}

{ #category : #'initialize-release' }
Oddly >> close [
	urbit close.
]

{ #category : #initialization }
Oddly >> initialize [
	metadataStore := MetadataStore new.
	graphStore := GraphStore new.
	messageHandler := MessageHandler new
		metadataStore: metadataStore;
		graphStore: graphStore.
	client := ZnClient new timeout: 30.
	sseclient := SSEClient new 
		client: client;
		messageHandler: messageHandler.
	metadataList := MetadataList new
		metadataStore: metadataStore;
		subscribeTo: metadataStore announcer;
		openWithSpec.
	ui := OddlyView new
		graphStore: graphStore;
		subscribeTo: graphStore announcer;
		openWithSpec.
	urbit := Urbit new
		client: client;
		sseclient: sseclient;
		connect.
]
