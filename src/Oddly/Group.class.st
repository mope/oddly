Class {
	#name : #Group,
	#superclass : #MetadataAssociation,
	#category : #Oddly
}

{ #category : #accessing }
Group >> chats [

	^ self store groupChats: self group
]

{ #category : #accessing }
Group >> links [

	^ self store groupLinks: self group
]

{ #category : #accessing }
Group >> publishes [

	^ self store groupPublishes: self group
]
