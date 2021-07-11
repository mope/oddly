Class {
	#name : #MetadataStore,
	#superclass : #Store,
	#instVars : [
		'groups',
		'graph'
	],
	#category : #Oddly
}

{ #category : #adding }
MetadataStore >> add: message [
	| associations  |
	
	associations := ((message at: 'json') at: 'metadata-update') at: 'associations'.
	groups := associations select: [ :association | (association at: 'app-name') = 'groups' ].
	graph := associations select: [ :association | (association at: 'app-name') = 'graph' ].
	announcer announce: announcementClass new.
]

{ #category : #accessing }
MetadataStore >> graph [
	^ graph
]

{ #category : #accessing }
MetadataStore >> groups [
	^ groups
]

{ #category : #initialization }
MetadataStore >> initialize [
   super initialize.
	announcementClass := MetadataUpdate.
	groups := Dictionary new.
	graph := Dictionary new.

]
