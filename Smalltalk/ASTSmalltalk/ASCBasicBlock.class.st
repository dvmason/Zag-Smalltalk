"
I represent a Basic Block for ASCodeGenerator.

Every Method or block is made up of a graph of these.

I have a `then` field which is the block I will go to if the named test is true.

If there is no test, or if the test is false, then I will continue with the `else` block.
"
Class {
	#name : #ASCBasicBlock,
	#superclass : #Object,
	#instVars : [
		'stack',
		'maxDepth',
		'operations',
		'label',
		'index',
		'end',
		'next'
	],
	#category : #'ASTSmalltalk-CodeGen'
}

{ #category : #adding }
ASCBasicBlock >> addTo: aCollection [ 
	self shouldBeImplemented.
]

{ #category : #API }
ASCBasicBlock >> assignLocal: anASLocal [

	| target |
	target := stack find: anASLocal name.
	self put: (ASCStoreLocal with: target)
]

{ #category : #stackAccessHelpers }
ASCBasicBlock >> doCall: aSymbol [

	stack := stack drop: aSymbol numArgs
]

{ #category : #stackAccessHelpers }
ASCBasicBlock >> doDrop [

	stack := stack drop.

]

{ #category : #stackAccessHelpers }
ASCBasicBlock >> doDrop: n [

	stack := stack drop: n.

]

{ #category : #stackAccessHelpers }
ASCBasicBlock >> doPop [

	| result |
	result := stack value.
	stack := stack drop.
	^ result
]

{ #category : #stackAccessHelpers }
ASCBasicBlock >> doPush: anObject [

	stack := stack push: anObject.
	maxDepth := maxDepth max: stack depth
]

{ #category : #accessing }
ASCBasicBlock >> end: anASCOperation [ 
	end := anASCOperation
]

{ #category : #initialization }
ASCBasicBlock >> endWithReturnTop [

		end := ASCReturnTop new
]

{ #category : #accessing }
ASCBasicBlock >> index [
	^ index
]

{ #category : #initialization }
ASCBasicBlock >> initialize [

	super initialize.
	operations := OrderedCollection new.
	end := ASCReturnSelf new 
]

{ #category : #initialization }
ASCBasicBlock >> label [
	^ label
]

{ #category : #initialization }
ASCBasicBlock >> label: aString index: anInteger [

	label := aString .
	index := anInteger 
]

{ #category : #accessing }
ASCBasicBlock >> maxDepth [
	^ maxDepth
]

{ #category : #accessing }
ASCBasicBlock >> next [
	^ next
]

{ #category : #wriiting }
ASCBasicBlock >> outputRestTo: output [

	operations do: [ :operation | operation outputTo: output ].
	end outputTo: output.
	output outputMethodEnd
]

{ #category : #wriiting }
ASCBasicBlock >> outputTo: output [

	self subclassResponsibility 
]

{ #category : #API }
ASCBasicBlock >> popLocal: anASCLocal [

	| target |
	target := stack find: anASCLocal name.
	self put: (ASCPopLocal with: target).
	self doDrop
]

{ #category : #API }
ASCBasicBlock >> pushLocal: anASCLocal [

	| target |
	target := stack find: anASCLocal name.
	self put: (ASCPushLocal with: target).
	self doPush: target top
]

{ #category : #API }
ASCBasicBlock >> pushUnknownNamed: aSymbol [

	stack := ASStackNamed new
		         from: stack;
		         name: aSymbol.
	stack top: (ASCClassValue new init: Object)
]

{ #category : #initialization }
ASCBasicBlock >> put: anObject [
	operations add: anObject 
]

{ #category : #initialization }
ASCBasicBlock >> returnTop [
		self doDrop.
		end := ASCReturnTop new

]

{ #category : #'abstract interpretation' }
ASCBasicBlock >> send: aSymbol with: aGenerator target: aTarget tail: tailCall [

	| numArgs params target |
	numArgs := aSymbol numArgs.
	params := Array new: numArgs.
	target := aTarget isSymbol ifTrue: [ aTarget ] ifFalse: [ nil ].
	[ numArgs > 0 ] whileTrue: [
		params at: numArgs put: stack top.
		self doDrop.
		numArgs := numArgs - 1 ].
	stack top: (aGenerator eval: aSymbol params: params).
	next := ASCReturnBlock new
		        stack: stack;
		        end: end.
	end := ASCSend new
		       selector: aSymbol;
		       return: next;
		target: target; tail: tailCall.
	^ next
]

{ #category : #accessing }
ASCBasicBlock >> stack: anASStack [

	stack := anASStack.
	maxDepth := stack depth
]

{ #category : #accessing }
ASCBasicBlock >> top [
	^ stack top
]