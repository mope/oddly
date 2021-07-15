Class {
	#name : #MetadataList,
	#superclass : #SpPresenter,
	#instVars : [
		'groupList',
		'chatList',
		'metadataStore',
		'oddly'
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
	chatList whenSelectionChangedDo: [ :selection |
		selection selectedItem ifNotNil: [
			" FIXME add a Backlog class? "
			OddlyView new setText: (oddly backlog: selection selectedItem shortResource) contents; openWithSpec.
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

{ #category : #accessing }
MetadataList >> oddly: o [
	oddly := o
]

{ #category : #subscription }
MetadataList >> subscribeTo: anAnnouncer [
    
anAnnouncer when: MetadataUpdate
	do: [
		groupList items: (metadataStore groups values).
 	]
]
