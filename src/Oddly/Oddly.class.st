Class {
	#name : #Oddly,
	#superclass : #Object,
	#instVars : [
		'ui',
		'urbit'
	],
	#category : #Oddly
}

{ #category : #'initialize-release' }
Oddly >> close [
	urbit close.
]

{ #category : #initialization }
Oddly >> initialize [
	ui := OddlyView new.
	urbit := Urbit new.
	urbit ui: ui.
	ui openWithSpec.
	urbit connect.
]
