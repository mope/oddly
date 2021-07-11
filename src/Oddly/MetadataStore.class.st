Class {
	#name : #MetadataStore,
	#superclass : #Store,
	#category : #Oddly
}

{ #category : #initialization }
MetadataStore >> initialize [
   super initialize.
	announcementClass := MetadataUpdate.

]
