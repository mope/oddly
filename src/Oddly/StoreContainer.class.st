Class {
	#name : #StoreContainer,
	#superclass : #Object,
	#instVars : [
		'graphStore',
		'metadataStore'
	],
	#category : #Oddly
}

{ #category : #accessing }
StoreContainer >> add: raw [
	| message |
	message := raw.
	
	(message includesKey: 'json') ifTrue: [
		message := message at: 'json'.
	].
	(message includesKey: 'graph-update') ifTrue: [
		graphStore add: message.	
	].
	(message includesKey: 'metadata-update') ifTrue: [
		metadataStore add: message.	
	]

]

{ #category : #accessing }
StoreContainer >> graphStore [
	
	^ graphStore
]

{ #category : #accessing }
StoreContainer >> graphStore: g [
	graphStore := g
]

{ #category : #accessing }
StoreContainer >> metadataStore [
	
	^ metadataStore
]

{ #category : #accessing }
StoreContainer >> metadataStore: m [
	metadataStore := m
]
