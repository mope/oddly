Class {
	#name : #GraphStoreNode,
	#superclass : #Object,
	#classVars : [
		'children',
		'post'
	],
	#category : #Oddly
}

{ #category : #'instance creation' }
GraphStoreNode class >> with: dictionary [
	| instance |
	
	instance := self new.
	instance post: (GraphStorePost with: (dictionary at: 'post')).
	instance children: (dictionary at: 'children').
	^ instance
]
