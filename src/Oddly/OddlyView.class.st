Class {
	#name : #OddlyView,
	#superclass : #SpPresenter,
	#instVars : [
		'textPresenter',
		'buffer',
		'graphStore',
		'metadataStore'
	],
	#category : #Oddly
}

{ #category : #specs }
OddlyView class >> defaultSpec [ 
	^ SpBoxLayout newTopToBottom
		add: #textPresenter;
		yourself
]

{ #category : #'accessing - text' }
OddlyView >> appendText: text [
	buffer := buffer, String cr, text.
	self setText: buffer.
]

{ #category : #accessing }
OddlyView >> graphStore: g [
	graphStore := g
]

{ #category : #initialization }
OddlyView >> initializePresenters [
	buffer := ''.
	textPresenter := self newText.
	
	textPresenter text: '';
	beNotEditable
]

{ #category : #accessing }
OddlyView >> metadataStore: m [
	metadataStore := m
]

{ #category : #accessing }
OddlyView >> setText: value [
	textPresenter text: value
]

{ #category : #subscription }
OddlyView >> subscribeTo: anAnnouncer [
    anAnnouncer when: GraphUpdate
    do: [ self setText: graphStore asString ].
    anAnnouncer when: MetadataUpdate
    do: [ self setText: metadataStore asString ].
	
]
