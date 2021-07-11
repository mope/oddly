Class {
	#name : #MetadataList,
	#superclass : #SpPresenter,
	#instVars : [
		'groupList',
		'graphList',
		'metadataStore'
	],
	#category : #Oddly
}

{ #category : #initialization }
MetadataList class >> defaultSpec [
	^ SpBoxLayout newLeftToRight
		add: #groupList;
			yourself;
		add: #graphList;
			yourself;
		yourself.
			
]

{ #category : #accessing }
MetadataList >> graphList [
	^ graphList
]

{ #category : #accessing }
MetadataList >> groupList [
	^ groupList
]

{ #category : #initialization }
MetadataList >> initializePresenters [
	groupList := self newList.
	graphList := self newList.
	
]

{ #category : #accessing }
MetadataList >> metadataStore: m [
	metadataStore := m
]

{ #category : #subscription }
MetadataList >> subscribeTo: anAnnouncer [
    
	anAnnouncer when: MetadataUpdate
		do: [
			groupList items: (metadataStore groups values collect: [ :group | (group at: 'metadata') at: 'title' ]).
			graphList items: (metadataStore graph values collect: [ :group | (group at: 'metadata') at: 'title' ]).
	 	]
]
