Extension { #name : 'Symbol' }

{ #category : '*ASTSmalltalk' }
Symbol >> zigCompileObject: aWriteStream [

	aWriteStream putSymbol: self
]

{ #category : '*ASTSmalltalk' }
Symbol >> zigCompileObjectReference: anASZigCompileObjectGenerator [

	^ nil
]
