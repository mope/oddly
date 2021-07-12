Class {
	#name : #MetadataAssociation,
	#superclass : #Object,
	#instVars : [
		'resource',
		'group',
		'title',
		'creator'
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

{ #category : #accessing }
MetadataAssociation >> title [

	^ title
]

{ #category : #accessing }
MetadataAssociation >> title: anObject [

	title := anObject
]
