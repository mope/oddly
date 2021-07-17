Class {
	#name : #ChatWindow,
	#superclass : #SpPresenter,
	#instVars : [
		'storeContainer',
		'messageList',
		'resource',
		'title'
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

{ #category : #initialization }
ChatWindow >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: title;
		initialExtent: 500@500
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
	| graphNodes posts | 
	anAnnouncer when: GraphUpdate
		do: [
			graphNodes := ((storeContainer graphStore) nodes: resource) values sorted: [
				:a :b | ((a at: 'post') at: 'time-sent') > ((b at: 'post') at: 'time-sent')	
			].
			posts := graphNodes collect: [ :node |
				 ((node at: 'post') at: 'author'), ': ', ((((node at: 'post') at: 'contents') at: 1) at: 'text')
			].
			messageList items: posts.
 		]
]

{ #category : #accessing }
ChatWindow >> title: t [
	title := t
]
