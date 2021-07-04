Class {
	#name : #OddlyView,
	#superclass : #SpPresenter,
	#instVars : [
		'textPresenter',
		'buffer'
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

{ #category : #initialization }
OddlyView >> initializePresenters [
	buffer := ''.
	textPresenter := self newText.
	
	textPresenter text: '';
	beNotEditable
]

{ #category : #accessing }
OddlyView >> setText: value [
	textPresenter text: value
]
