Class {
	#name : #Store,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #Oddly
}

{ #category : #accessing }
Store >> announcer [
	^ announcer
]

{ #category : #initialization }
Store >> initialize [
	announcer := Announcer new.
]
