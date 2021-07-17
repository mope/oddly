Class {
	#name : #ChatWindow,
	#superclass : #SpPresenter,
	#instVars : [
		'storeContainer',
		'messageList',
		'resource'
	],
	#category : #Oddly
}

{ #category : #specs }
ChatWindow class >> defaultSpec [
	^ SpBoxLayout newLeftToRight
		add: #messageList;
			yourself;
		yourself.
]

{ #category : #initialization }
ChatWindow >> initializePresenters [
	messageList := self newList.
]

{ #category : #accessing }
ChatWindow >> resource: r [
	resource := r
]

{ #category : #accessing }
ChatWindow >> storeContainer: s [
	storeContainer := s
]

{ #category : #subscription }
ChatWindow >> subscribeTo: anAnnouncer [
    
anAnnouncer when: GraphUpdate
	do: [
		messageList items: (((storeContainer graphStore) nodes: resource) values).
 	]
]
