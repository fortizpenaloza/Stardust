"
I'm the default picking policy.
"
Class {
	#name : #PickModelPolicy,
	#superclass : #ModelPickingPolicy,
	#category : #Stardust
}

{ #category : #testing }
PickModelPolicy >> is: anObject equalTo: aModel [

	^ anObject = aModel
]

{ #category : #'selection protocol' }
PickModelPolicy >> pickFrom: aModel [

	^ aModel
]
