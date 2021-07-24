Class {
	#name : #MessageHandler,
	#superclass : #Object,
	#instVars : [
		'urbit',
		'storeContainer'
	],
	#category : #Oddly
}

{ #category : #adding }
MessageHandler >> add: message [
	urbit ack: message id.
	storeContainer add: (STONJSON fromString: message data).
]

{ #category : #accessing }
MessageHandler >> storeContainer: s [
	storeContainer := s
]

{ #category : #accessing }
MessageHandler >> urbit: u [
	urbit := u
]
