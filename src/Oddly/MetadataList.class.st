Class {
	#name : #MetadataList,
	#superclass : #SpPresenter,
	#instVars : [
		'groupList',
		'chatList',
		'metadataStore'
	],
	#category : #Oddly
}

{ #category : #initialization }
MetadataList class >> defaultSpec [
	^ SpBoxLayout newLeftToRight
		add: #groupList;
			yourself;
		add: #chatList;
			yourself;
		yourself.
			
]

{ #category : #accessing }
MetadataList >> chatList [
	^ chatList
]

{ #category : #initialization }
MetadataList >> connectPresenters [
	groupList whenSelectionChangedDo: [ :selection |
		selection selectedItem ifNotNil: [ 
			chatList items: selection selectedItem chats values.
		].
	].

]

{ #category : #accessing }
MetadataList >> groupList [
	^ groupList
]

{ #category : #initialization }
MetadataList >> initializePresenters [
	groupList := self newList.
	chatList := self newList.
	
]

{ #category : #accessing }
MetadataList >> metadataStore: m [
	metadataStore := m
]

{ #category : #subscription }
MetadataList >> subscribeTo: anAnnouncer [
    
anAnnouncer when: MetadataUpdate
	do: [
		groupList items: (metadataStore groups values).
 	]
]
