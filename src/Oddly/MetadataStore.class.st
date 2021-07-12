Class {
	#name : #MetadataStore,
	#superclass : #Store,
	#instVars : [
		'groups',
		'chats',
		'publishes',
		'links'
	],
	#category : #Oddly
}

{ #category : #adding }
MetadataStore >> add: message [
	| items groupsDictionary |
	
	items := ((message at: 'json') at: 'metadata-update') at: 'associations'.
	groupsDictionary := items associationsSelect: [ :association | (association value at: 'app-name') = 'groups' ].
	groups := groupsDictionary collect: [ :value | Group with: value ].
	items associationsDo: [ :association | 
		((association value at: 'app-name') = 'graph') ifTrue: [ 
			((((association value at: 'metadata') at: 'config') at: 'graph') = 'chat') ifTrue: [ 
				chats at: association key put: (Chat with: association value).
			].
			((((association value at: 'metadata') at: 'config') at: 'graph') = 'publish') ifTrue: [ 
				publishes at: association key put: (Publish with: association value).
			].
			((((association value at: 'metadata') at: 'config') at: 'graph') = 'link') ifTrue: [ 
				links at: association key put: (Links with: association value).
			].
		].
	].
	announcer announce: announcementClass new.
]

{ #category : #accessing }
MetadataStore >> chats [

	^ chats
]

{ #category : #accessing }
MetadataStore >> chats: anObject [

	chats := anObject
]

{ #category : #accessing }
MetadataStore >> groups [
	^ groups
]

{ #category : #accessing }
MetadataStore >> groups: anObject [

	groups := anObject
]

{ #category : #initialization }
MetadataStore >> initialize [
   super initialize.
	announcementClass := MetadataUpdate.
	groups := Dictionary new.
	chats := Dictionary new.
	publishes := Dictionary new.
	links := Dictionary new.

]

{ #category : #accessing }
MetadataStore >> links [

	^ links
]

{ #category : #accessing }
MetadataStore >> links: anObject [

	links := anObject
]

{ #category : #accessing }
MetadataStore >> publishes [

	^ publishes
]

{ #category : #accessing }
MetadataStore >> publishes: anObject [

	publishes := anObject
]
