"
Clean up stack and return self
"
Class {
	#name : #ASCReturnSelf,
	#superclass : #ASCOperations,
	#category : #'ASTSmalltalk-CodeGen'
}

{ #category : #'code generation' }
ASCReturnSelf >> outputTo: output [

	output visitReturnSelf
]

{ #category : #'instance creation' }
ASCReturnSelf >> with: ignored [


]