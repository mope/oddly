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
	
	name := ((((message at: 'json') at: 'graph-update') at: 'add-nodes') at: 'resource') at: 'name'.
	ship := ((((message at: 'json') at: 'graph-update') at: 'add-nodes') at: 'resource') at: 'ship'.
	resource := ship, '/', name.
	(graph includesKey: resource) ifFalse: [ 
		graph at: resource put: Dictionary new.
	].
	nodes := (((message at: 'json') at: 'graph-update') at: 'add-nodes') at: 'nodes'.
	nodes keysAndValuesDo: [ :k :v | graph at: resource at: k put: v ]. 
	announcer announce: GraphUpdate new.
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
