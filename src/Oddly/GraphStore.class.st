Class {
	#name : #GraphStore,
	#superclass : #Store,
	#category : #Oddly
}

{ #category : #initialization }
GraphStore >> initialize [
   super initialize.
	announcementClass := GraphUpdate.

]
