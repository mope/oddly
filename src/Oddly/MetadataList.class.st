Class {
	#name : #MetadataList,
	#superclass : #SpPresenter,
	#instVars : [
		'groupList',
		'chatList',
		'storeContainer',
		'oddly',
		'title'
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
	chatList whenActivatedDo: [ :selection |
		selection selectedItem ifNotNil: [
			" FIXME shortResource should be somewhere else "
			oddly newChatWindow: selection selectedItem
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
	chatList := self newList activateOnDoubleClick.
	
]

{ #category : #initialization }
MetadataList >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: title;
		initialExtent: 500@500
]

{ #category : #accessing }
MetadataList >> oddly: o [
	oddly := o
]

{ #category : #accessing }
MetadataList >> storeContainer: s [
	storeContainer := s
]

{ #category : #subscription }
MetadataList >> subscribeTo: anAnnouncer [
    
anAnnouncer when: MetadataUpdate
	do: [
		groupList items: (storeContainer metadataStore groups values).
 	]
]

{ #category : #accessing }
MetadataList >> title: t [
	title := t
]
