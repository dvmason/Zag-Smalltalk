Class {
	#name : 'ASImproperId',
	#superclass : 'ASIdentifier',
	#category : 'ASTSmalltalk-Tokens',
	#package : 'ASTSmalltalk',
	#tag : 'Tokens'
}

{ #category : 'parsing' }
ASImproperId >> assignExpression: anASCompiler [
	^ self error: 'Invalid identifier: ',value
]

{ #category : 'parsing' }
ASImproperId >> binaryExpression: anASCompiler [
	^ self error: 'Invalid identifier: ',value
]

{ #category : 'parsing' }
ASImproperId >> keywordExpression: anASCompiler [
	^ self error: 'Invalid identifier: ',value
]

{ #category : 'parsing' }
ASImproperId >> parseWith: anASCompiler [
	^ self error: 'Invalid identifier: ',value
]

{ #category : 'parsing' }
ASImproperId >> unaryExpression: anASCompiler [
	^ self error: 'Invalid identifier: ',value
]
