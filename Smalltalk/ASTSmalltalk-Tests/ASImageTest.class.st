Class {
	#name : 'ASImageTest',
	#superclass : 'TestCase',
	#pools : [
		'ASZagConstants'
	],
	#category : 'ASTSmalltalk-Tests-Tests',
	#package : 'ASTSmalltalk-Tests',
	#tag : 'Tests'
}

{ #category : 'running' }
ASImageTest >> image: aBlock equals: value [

	| result |
	result := ByteArray streamContents: [ :s |
		          aBlock value: (ASNanImage test on: s) ].
	value isInteger
		ifTrue: [
			self
				assert: (self u64From: result) first hexString
				equals: value hexString ]
		ifFalse: [
			self
				assert: ((self u64From: result) collect: #hexString)
				equals: (value collect: #hexString) ]
]

{ #category : 'running' }
ASImageTest >> setUp [

	super setUp.

	ASAllocationInfo reset
]

{ #category : 'tests' }
ASImageTest >> threaded: ast equals: converted [

	| image map |
	map := ASZagConstants constantMap.
	image := self imageClass test on: (ReadWriteStream on: #[  ]).
	ASImageThreadedOutput new
		context: (ASImageFileContext with: image);
		generateCode: ast.
	converted withIndexDo: [ :each :idx |
		| code |
		code := image rawIntAt: idx.
		each isSymbol
			ifTrue: [
				self
					assert: code = (map at: each)
					description: [
					'expected: ' , each , ' but found: ' , code hexString ] ]
			ifFalse: [
				each isNumber
					ifTrue: [
					self assert: code equals: (self imageClass convertNumber: each) ]
					ifFalse: [ self assert: code equals: each ] ] ]
]

{ #category : 'running' }
ASImageTest >> u64From: aByteArray [

	^ ((aByteArray groupsOf: 8) collect: [ :group |
		  group reversed
			  inject: 0
			  into: [ :t :each | (t bitShift: 8) + each ] ]) asArray
]
