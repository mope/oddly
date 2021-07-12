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
		Transcript show: String cr, 'ANNOUNCEMENT RECEIVED', String cr.
		Transcript show: metadataStore groups.
		groupList items: (metadataStore groups values collect: [
			 :group | group asString 
			]).
		chatList items: (metadataStore chats values collect: [
			 :chat | chat asString 
			]).
 		]
]
