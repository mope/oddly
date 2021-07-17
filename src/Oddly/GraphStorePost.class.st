Class {
	#name : #GraphStorePost,
	#superclass : #Object,
	#instVars : [
		'index',
		'author',
		'timeSent',
		'signatures',
		'contents',
		'hash'
	],
	#category : #Oddly
}

{ #category : #'instance creation' }
GraphStorePost class >> with: dictionary [
	| instance |
	
	instance := self new.
	instance index: (dictionary at: 'index').
	instance contents: (dictionary at: 'contents').
	instance hash: (dictionary at: 'hash').
	instance signatures: (dictionary at: 'signatures').
	instance timeSent: (dictionary at: 'timeSent').
	^ instance
]

{ #category : #accessing }
GraphStorePost >> author [

	^ author
]

{ #category : #accessing }
GraphStorePost >> author: anObject [

	author := anObject
]

{ #category : #accessing }
GraphStorePost >> contents [

	^ contents
]

{ #category : #accessing }
GraphStorePost >> contents: anObject [

	contents := anObject
]

{ #category : #accessing }
GraphStorePost >> hash1 [

	^ hash
]

{ #category : #accessing }
GraphStorePost >> hash: anObject [

	hash := anObject
]

{ #category : #accessing }
GraphStorePost >> index [

	^ index
]

{ #category : #accessing }
GraphStorePost >> index: anObject [

	index := anObject
]

{ #category : #accessing }
GraphStorePost >> signatures [

	^ signatures
]

{ #category : #accessing }
GraphStorePost >> signatures: anObject [

	signatures := anObject
]

{ #category : #accessing }
GraphStorePost >> timeSent [

	^ timeSent
]

{ #category : #accessing }
GraphStorePost >> timeSent: anObject [

	timeSent := anObject
]
