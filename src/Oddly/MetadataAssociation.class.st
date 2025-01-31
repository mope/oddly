Class {
	#name : #MetadataAssociation,
	#superclass : #Object,
	#instVars : [
		'resource',
		'group',
		'title',
		'creator',
		'store'
	],
	#category : #Oddly
}

{ #category : #'instance creation' }
MetadataAssociation class >> with: dictionary [
	| association |
	
	association := self new.
	association creator: ((dictionary at: 'metadata') at: 'creator').
	association title: ((dictionary at: 'metadata') at: 'title').
	association group: (dictionary at: 'group').
	association resource: (dictionary at: 'resource').
	^ association
]

{ #category : #'instance creation' }
MetadataAssociation class >> with: dictionary store: store [
	| association |
	
	association := self new.
	association creator: ((dictionary at: 'metadata') at: 'creator').
	association title: ((dictionary at: 'metadata') at: 'title').
	association group: (dictionary at: 'group').
	association resource: (dictionary at: 'resource').
	association store: store.
	^ association
]

{ #category : #converting }
MetadataAssociation >> asString [
	^ self title
]

{ #category : #accessing }
MetadataAssociation >> creator [

	^ creator
]

{ #category : #accessing }
MetadataAssociation >> creator: anObject [

	creator := anObject
]

{ #category : #accessing }
MetadataAssociation >> group [

	^ group
]

{ #category : #accessing }
MetadataAssociation >> group: anObject [

	group := anObject
]

{ #category : #accessing }
MetadataAssociation >> resource [

	^ resource
]

{ #category : #accessing }
MetadataAssociation >> resource: anObject [

	resource := anObject
]

{ #category : #'as yet unclassified' }
MetadataAssociation >> shortResource [
	" strip /ship/~ from resource "
	^ resource allButFirst: 7
]

{ #category : #accessing }
MetadataAssociation >> store [

	^ store
]

{ #category : #accessing }
MetadataAssociation >> store: anObject [

	store := anObject
]

{ #category : #accessing }
MetadataAssociation >> title [

	^ title
]

{ #category : #accessing }
MetadataAssociation >> title: anObject [

	title := anObject
]
