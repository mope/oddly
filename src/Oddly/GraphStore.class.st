Class {
	#name : #GraphStore,
	#superclass : #Store,
	#instVars : [
		'graph'
	],
	#category : #Oddly
}

{ #category : #adding }
GraphStore >> add: message [
	| name ship nodes resource |
	
	name := (((message at: 'graph-update') at: 'add-nodes') at: 'resource') at: 'name'.
	ship := (((message at: 'graph-update') at: 'add-nodes') at: 'resource') at: 'ship'.
	resource := ship, '/', name.
	nodes := ((message at: 'graph-update') at: 'add-nodes') at: 'nodes'.
	nodes keysAndValuesDo: [ :index :node | | graphStorePost newNode |
		graphStorePost := GraphStorePost with: (node at: 'post').
		newNode := Dictionary new
						at: 'post' put: graphStorePost;
						at: 'children' put: (node at: 'children');
						yourself.
		graph at: resource at: index put: newNode.
	].
	announcer announce: GraphUpdate new.
]

{ #category : #adding }
GraphStore >> addOne: post resource: resource index: index [
	| node |
	
	node := Dictionary new
					at: 'post' put: post;
					at: 'children' put: nil;
					yourself.
	graph at: resource at: index put: node.
	announcer announce: GraphUpdate new.
]

{ #category : #accessing }
GraphStore >> graph [

	^ graph
]

{ #category : #initialization }
GraphStore >> initialize [
	super initialize.
	graph := Dictionary new.
]

{ #category : #accessing }
GraphStore >> nodes: resource [
	
	^ graph at: resource
]
