Class {
	#name : #MessageHandler,
	#superclass : #Object,
	#instVars : [
		'graphStore',
		'metadataStore'
	],
	#category : #Oddly
}

{ #category : #accessing }
MessageHandler >> add: raw [
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
MessageHandler >> graphStore: g [
	graphStore := g
]

{ #category : #accessing }
MessageHandler >> metadataStore: m [
	metadataStore := m
]
