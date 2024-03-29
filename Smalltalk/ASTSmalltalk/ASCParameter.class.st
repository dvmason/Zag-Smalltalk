"
I am a parameter for a method.
ASCSelf is a subclass
"
Class {
	#name : 'ASCParameter',
	#superclass : 'ASCValue',
	#instVars : [
		'offset',
		'stack'
	],
	#category : 'ASTSmalltalk-CodeGen',
	#package : 'ASTSmalltalk',
	#tag : 'CodeGen'
}

{ #category : 'instance creation' }
ASCParameter class >> inBasicBlock: anASCBasicBlock [ 
	^ self new inBasicBlock: anASCBasicBlock 
]

{ #category : 'instance initialization' }
ASCParameter >> inBasicBlock: anASCBasicBlock [ 
	stack := anASCBasicBlock stack
]

{ #category : 'testing' }
ASCParameter >> isImmediateThunk [
^ true
]

{ #category : 'accessing' }
ASCParameter >> offset [

	^ stack offsetTo: self name
]

{ #category : 'affecting' }
ASCParameter >> push: output [

	^ output visitPushLocal: self
]
