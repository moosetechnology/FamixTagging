Class {
	#name : 'FamixTagDependenciesTest',
	#superclass : 'TestCase',
	#instVars : [
		'model'
	],
	#category : 'Famix-Tagging-Tests',
	#package : 'Famix-Tagging-Tests'
}

{ #category : 'running' }
FamixTagDependenciesTest >> addDependencies [
	FamixTagTestInvocation source: self method1 target: {self method2}.

	FamixTagTestAccess source: self method1 target: (model entityNamed: 'Package3::Class3.Attribute3').

	FamixTagTestInvocation source: self method2 target: {self method1}
]

{ #category : 'running' }
FamixTagDependenciesTest >> createTestEntities: i [
	| class |
	class := (FamixTagTestClass named: 'Class' , i asString model: model)
		numberOfLinesOfCode: i * 10;
		typeContainer: (FamixTagTestPackage named: 'Package' , i asString model: model);
		yourself.
	(FamixTagTestMethod named: 'Method' , i asString model: model)
		numberOfLinesOfCode: i * 5;
		parentType: class.
	(FamixTagTestAttribute named: 'Attribute' , i asString model: model) parentType: class
]

{ #category : 'accessing' }
FamixTagDependenciesTest >> method1 [

	^ model entityNamed: 'Package1.Class1.Method1'
]

{ #category : 'accessing' }
FamixTagDependenciesTest >> method2 [

	^ model entityNamed: 'Package2.Class2.Method2'
]

{ #category : 'running' }
FamixTagDependenciesTest >> setUp [
	super setUp.
	model := FamixTagTestModel new.
	1 to: 3 do: [ :number | self createTestEntities: number ].
	self addDependencies.
	self tagEntities
]

{ #category : 'running' }
FamixTagDependenciesTest >> tagEntities [
	| parentTag classTag |
	parentTag := model createTagNamed: 'compositeTag1'.
	classTag := model createTagNamed: 'classTag1'.
	classTag parentTag: parentTag.
	(model entityNamed: 'Package1.Class1') tagWith: classTag.

	parentTag := model createTagNamed: 'compositeTag2'.
	classTag := model createTagNamed: 'classTag2'.
	classTag parentTag: parentTag.
	(model entityNamed: 'Package2.Class2') tagWith: classTag.

	classTag := model createTagNamed: 'classTag3'.
	(model entityNamed: 'Package3.Class3.Attribute3') tagWith: classTag
]

{ #category : 'accessing' }
FamixTagDependenciesTest >> tagNamed: aString [
	^ model tags detect: [ :tag | tag name = aString ]
]

{ #category : 'running' }
FamixTagDependenciesTest >> testClientsTagFromCompositeTag [
	self assert: ((self tagNamed: 'classTag2') allClientsIn: {(self tagNamed: 'compositeTag1')} forModel: model) size equals: 1
]

{ #category : 'tests' }
FamixTagDependenciesTest >> testNumberOfLinesOfCode [
	| compositeTag |
	compositeTag := model tagNamed: 'compositeTag1'.

	self assert: (compositeTag allEntitiesRecursivelyIn: model collect: #numberOfLinesOfCode) sumNumbers equals: 10.
	self assert: ((model tagNamed: 'compositeTag1>classTag1') allEntitiesRecursivelyIn: model collect: #numberOfLinesOfCode) sumNumbers equals: 10.
	self method1 tagWith: compositeTag.

	self assert: (compositeTag allEntitiesRecursivelyIn: model collect: #numberOfLinesOfCode) sumNumbers equals: 15.
	self assert: ((model tagNamed: 'compositeTag1>classTag1') allEntitiesRecursivelyIn: model collect: #numberOfLinesOfCode) sumNumbers equals: 10
]

{ #category : 'running' }
FamixTagDependenciesTest >> testProviderTagToCompositeTag [
	self assert: ((self tagNamed: 'classTag1') allProvidersIn: {(self tagNamed: 'compositeTag2')} forModel: model) size equals: 1
]
