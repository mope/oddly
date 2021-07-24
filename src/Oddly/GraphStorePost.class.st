Class {
	#name : #GraphStorePost,
	#superclass : #Object,
	#instVars : [
		'index',
		'author',
		'timeSent',
		'signatures',
		'contents',
		'hash'
	],
	#category : #Oddly
}

{ #category : #'as yet unclassified' }
GraphStorePost class >> unixToDa: number [
	| daUnixEpoch daSecond |
	
	daUnixEpoch := 170141184475152167957503069145530368000.
	daSecond := 18446744073709551616.
	^ (daUnixEpoch + ((number * daSecond) / 1000)) asInteger.
]

{ #category : #'instance creation' }
GraphStorePost class >> with: dictionary [
	| instance |
	
	instance := self new.
	
	instance author: (dictionary at: 'author').
	instance index: (dictionary at: 'index').
	instance contents: (dictionary at: 'contents').
	instance hash: (dictionary at: 'hash').
	instance signatures: (dictionary at: 'signatures').
	instance timeSent: (dictionary at: 'time-sent').
	^ instance
]

{ #category : #'instance creation' }
GraphStorePost class >> with: contents author: author [
	| instance |
	
	instance := self new.
	instance author: author.
	instance index: (self unixToDa: DateAndTime now asUnixTime).
	instance contents: contents.
	instance signatures: #().
	instance timeSent: DateAndTime now asUnixTime.
	^ instance
]

{ #category : #converting }
GraphStorePost >> asDictionary [
	
	^ Dictionary new
		at: 'author' put: '~', author;
		at: 'contents' put: contents;
		at: 'hash' put: hash;
		at: 'index' put: '/', index asString;
		at: 'signatures' put: signatures;
		at: 'time-sent' put: timeSent;
		yourself.
]

{ #category : #accessing }
GraphStorePost >> author [

	^ author
]

{ #category : #accessing }
GraphStorePost >> author: anObject [

	author := anObject
]

{ #category : #accessing }
GraphStorePost >> contents [

	^ contents
]

{ #category : #accessing }
GraphStorePost >> contents: anObject [

	contents := anObject
]

{ #category : #accessing }
GraphStorePost >> hash1 [

	^ hash
]

{ #category : #accessing }
GraphStorePost >> hash: anObject [

	hash := anObject
]

{ #category : #accessing }
GraphStorePost >> index [

	^ index
]

{ #category : #accessing }
GraphStorePost >> index: anObject [

	index := anObject
]

{ #category : #printing }
GraphStorePost >> printOn: aStream [

	author isNotNil ifTrue: [ 
		aStream
			nextPutAll: author.
	].
	index isNotNil ifTrue: [ 
		aStream
			nextPutAll: index asString.
	].
	timeSent isNotNil ifTrue: [ 
		aStream
			nextPutAll: timeSent asString.
	].
]

{ #category : #accessing }
GraphStorePost >> signatures [

	^ signatures
]

{ #category : #accessing }
GraphStorePost >> signatures: anObject [

	signatures := anObject
]

{ #category : #accessing }
GraphStorePost >> timeSent [

	^ timeSent
]

{ #category : #accessing }
GraphStorePost >> timeSent: anObject [

	timeSent := anObject
]
