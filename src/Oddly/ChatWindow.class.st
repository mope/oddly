Class {
	#name : #ChatWindow,
	#superclass : #SpPresenter,
	#instVars : [
		'storeContainer',
		'messageList',
		'messageInput',
		'resource',
		'title',
		'urbit',
		'ship'
	],
	#category : #Oddly
}

{ #category : #specs }
ChatWindow class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #messageList;
			yourself;
		add: #messageInput height: 10;
			yourself;
		yourself.
]

{ #category : #initialization }
ChatWindow >> initializePresenters [
	messageList := self newList.
	messageInput := self newTextInput whenSubmitDo: [ :textMorph | | contents post node nodes addNodes  message array |
		contents := Dictionary new
							at: 'text' put: textMorph text asString;
							yourself.
		array := Array new: 1.
		array at: 1 put: contents.
		post := GraphStorePost with: array author: ship.
		node := Dictionary new
					at: 'children' put: nil;
					at: 'post' put: post asDictionary;
					yourself.
		nodes := Dictionary new
						at: '/', post index asString put: node;
						yourself.
		addNodes := Dictionary new
							at: 'nodes' put: nodes;
							at: 'resource' put: (Dictionary new at: 'ship' put: '~zod'; at: 'name' put: 'bazquux-754'; yourself);
							yourself.
		message := Dictionary new
						at: 'add-nodes' put: addNodes;
						yourself.
		urbit spider: message
			threadName: 'graph-add-nodes'
			inputMark: 'graph-update-2'
			outputMark: 'graph-view-action'.
		storeContainer graphStore addOne: post resource: 'zod/bazquux-754' index: '/', post index.
	].
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
ChatWindow >> ship [

	^ ship
]

{ #category : #accessing }
ChatWindow >> ship: s [

	ship := s
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
				:a :b | (a at: 'post') timeSent < (b at: 'post') timeSent	
			].
			posts := graphNodes collect: [ :node |
				 (node at: 'post') author, ': ', ((((node at: 'post') contents) at: 1) at: 'text')
			].
			messageList items: posts.
			messageList selectIndex: (posts size) scrollToSelection: true.
 		]
]

{ #category : #accessing }
ChatWindow >> title: t [
	title := t
]

{ #category : #accessing }
ChatWindow >> urbit: u [

	urbit := u
]
