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
	| message body |
	
	message := STONJSON fromString: raw data.
	(message includesKey: 'json') ifTrue: [
		body := message at: 'json'.
		(body includesKey: 'graph-update') ifTrue: [
			graphStore add: message.	
		].
		(body includesKey: 'metadata-update') ifTrue: [
			metadataStore add: message.	
		]	
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
