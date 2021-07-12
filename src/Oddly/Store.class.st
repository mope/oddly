Class {
	#name : #Store,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'announcementClass',
		'messages'
	],
	#category : #Oddly
}

{ #category : #adding }
Store >> add: newObject [
	announcer announce: announcementClass new.
	messages add: newObject.
]

{ #category : #accessing }
Store >> announcer [
	^ announcer
]

{ #category : #converting }
Store >> asString [
	^ messages asString
]

{ #category : #initialization }
Store >> initialize [
	announcer := Announcer new.
	messages := OrderedCollection new.
]

{ #category : #accessing }
Store >> messages [
	^ messages
]
