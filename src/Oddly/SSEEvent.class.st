Class {
	#name : #SSEEvent,
	#superclass : #Object,
	#instVars : [
		'data',
		'event',
		'id',
		'retry'
	],
	#category : #Oddly
}

{ #category : #parsing }
SSEEvent class >> parse: raw [
	| message lines re name_ value |
	re := '([^:]*)(\:? ?)(.*)' asRegex.
	message := self new.
	lines := raw splitOn: '\n'.
	lines do: [ 
		:line |
		(re matchesPrefix: line) ifTrue: [ 
				name_ := re subexpression: 2.
				" If name is empty then the line started with a : so ignore it "
				name_ ifNotEmpty: [ 
					value := re subexpression: 4.
					" this probably needs to be a separate method with ifTrue return "
					name_ = 'data' ifTrue: [ message data: value ].
					name_ = 'event' ifTrue: [ message event: value ].
					name_ = 'id' ifTrue: [ message id: value ].
					name_ = 'retry' ifTrue: [ message retry: value asNumber ].
				]

		]
   ].
	^ message
]

{ #category : #accessing }
SSEEvent >> data [
	^ data
]

{ #category : #accessing }
SSEEvent >> data: d [
	data ifNotEmpty: [ data := data, '\n', d ]  ifEmpty: [ data := d ]
	
]

{ #category : #accessing }
SSEEvent >> event: e [
	event := e
]

{ #category : #testing }
SSEEvent >> hasId [
	^ id isNotNil
]

{ #category : #accessing }
SSEEvent >> id [
	^ id
]

{ #category : #accessing }
SSEEvent >> id: i [
	id := i
]

{ #category : #initialization }
SSEEvent >> initialize [
	data := ''.
	event := ''.
	id := ''.
	retry := ''
]

{ #category : #printing }
SSEEvent >> printOn: aStream [
	data ifNotNil: [ aStream nextPutAll: data ].
	self storeOn: aStream
]

{ #category : #accessing }
SSEEvent >> retry [
	^ retry
]

{ #category : #accessing }
SSEEvent >> retry: r [
	retry := r
]
