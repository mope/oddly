Class {
	#name : #OddlyView,
	#superclass : #SpPresenter,
	#instVars : [
		'textPresenter'
	],
	#category : #Oddly
}

{ #category : #specs }
OddlyView class >> defaultSpec [ 
	^ SpBoxLayout newTopToBottom
		add: #textPresenter;
		yourself
]

{ #category : #initialization }
OddlyView >> initializePresenters [
	textPresenter := self newText.
	
	textPresenter text: '';
	beNotEditable
]

{ #category : #accessing }
OddlyView >> setText: value [
	textPresenter text: value
]
