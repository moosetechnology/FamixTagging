"
test that when entities passed a scope, they reply their outgoing or incoming according to that scope.
"
Class {
	#name : 'FamixTaggingDependencyDetectorTest',
	#superclass : 'TestCase',
	#instVars : [
		'model'
	],
	#category : 'Famix-Tagging-Tests',
	#package : 'Famix-Tagging-Tests'
}

{ #category : 'running' }
FamixTaggingDependencyDetectorTest >> a3 [
	^ model entityNamed: 'Class3.attribute3'
]

{ #category : 'helpers' }
FamixTaggingDependencyDetectorTest >> c1 [
	^ model entityNamed: 'Class1'
]

{ #category : 'helpers' }
FamixTaggingDependencyDetectorTest >> c2 [
	^ model entityNamed: 'Class2'
]

{ #category : 'helpers' }
FamixTaggingDependencyDetectorTest >> c3 [
	^ model entityNamed: 'Class3'
]

{ #category : 'helpers' }
FamixTaggingDependencyDetectorTest >> compositeTag1 [
	^ self tagNamed: 'compositeTag1'
]

{ #category : 'helpers' }
FamixTaggingDependencyDetectorTest >> compositeTag2 [
	^ self tagNamed: 'compositeTag2'
]

{ #category : 'helpers' }
FamixTaggingDependencyDetectorTest >> createTags [
	| parentTag classTag |
	parentTag := model createTagNamed: 'compositeTag1'.
	classTag := model createTagNamed: 'classTag1'.
	classTag parentTag: parentTag.
	(model entityNamed: 'Class1') tagWith: classTag.
	parentTag := model createTagNamed: 'compositeTag2'.
	classTag := model createTagNamed: 'classTag2'.
	classTag parentTag: parentTag.
	(model entityNamed: 'Class2') tagWith: classTag
]

{ #category : 'running' }
FamixTaggingDependencyDetectorTest >> createTestEntities: counter [
	| package class method attribute |
	package := FamixTest3Package named: 'package' , counter asString model: model.
	class := FamixTest3Class named: 'Class' , counter asString model: model.
	method := FamixTest3Method named: 'method' , counter asString model: model.
	attribute := FamixTest3Attribute named: 'attribute' , counter asString model: model.

	package addChildEntity: class.
	method parentType: class.
	attribute parentType: class
]

{ #category : 'helpers' }
FamixTaggingDependencyDetectorTest >> m1 [
	^ model entityNamed: 'Class1.method1'
]

{ #category : 'helpers' }
FamixTaggingDependencyDetectorTest >> m2 [
	^ model entityNamed: 'Class2.method2'
]

{ #category : 'helpers' }
FamixTaggingDependencyDetectorTest >> p1 [
	^ model entityNamed: 'package1'
]

{ #category : 'helpers' }
FamixTaggingDependencyDetectorTest >> p2 [
	^ model entityNamed: 'package2'
]

{ #category : 'helpers' }
FamixTaggingDependencyDetectorTest >> p3 [
	^ model entityNamed: 'package3'
]

{ #category : 'running' }
FamixTaggingDependencyDetectorTest >> setUp [
	super setUp.
	model := FamixTest3Model new.
	1 to: 3 do: [ :number | self createTestEntities: number ].
	FamixTest3Invocation source: self m1 target: {self m2} model: model.
	FamixTest3Invocation source: self m2 target: {self m1} model: model.
	FamixTest3Access source: self m1 target: self a3
]

{ #category : 'helpers' }
FamixTaggingDependencyDetectorTest >> tag1 [
	^ self tagNamed: #classTag1
]

{ #category : 'helpers' }
FamixTaggingDependencyDetectorTest >> tag2 [
	^ self tagNamed: #classTag2
]

{ #category : 'helpers' }
FamixTaggingDependencyDetectorTest >> tagNamed: aString [
	^ model tags detect: [ :tag | tag name = aString ] ifNone: [ nil ]
]

{ #category : 'tests' }
FamixTaggingDependencyDetectorTest >> testClientClassFromTags [
	self createTags.
	"not connected to its own tag"
	self assertCollection: (self c2 allClientsIn: {self tag1}) hasSameElements: {self tag1}.
	self assertCollection: (self c2 allClientsIn: {self compositeTag1}) hasSameElements: {self compositeTag1}
]

{ #category : 'tests' }
FamixTaggingDependencyDetectorTest >> testClientClassOwnTags [
	self createTags.
	"not connected to its own tag"
	self assertEmpty: (self c2 allClientsIn: {self tag2}).
	self assertEmpty: (self c2 allClientsIn: {self compositeTag2})
]

{ #category : 'tests' }
FamixTaggingDependencyDetectorTest >> testClientTagFromClasses [
	self createTags.
	"not connected to its own tag"
	self assertCollection: (self tag1 allClientsIn: {self m1 . self m2} forModel: model) hasSameElements: {self m2}.
	self assertCollection: (self compositeTag1 allClientsIn: {self m1 . self m2} forModel: model) hasSameElements: {self m2}
]

{ #category : 'tests' }
FamixTaggingDependencyDetectorTest >> testProviderClassOwnTags [
	self createTags.
	"not connected to its own tag"
	self assertEmpty: (self c1 allProvidersIn: {self tag1}).
	self assertEmpty: (self c1 allProvidersIn: {self compositeTag1})
]

{ #category : 'tests' }
FamixTaggingDependencyDetectorTest >> testProviderClassToTags [
	self createTags.
	"not connected to its own tag"
	self assertCollection: (self c1 allProvidersIn: {self tag2}) hasSameElements: {self tag2}.
	self assertCollection: (self c1 allProvidersIn: {self compositeTag2}) hasSameElements: {self compositeTag2}
]

{ #category : 'tests' }
FamixTaggingDependencyDetectorTest >> testProviderMethodToTags [
	<expectedFailure>
	self createTags.
	self flag: #TODO.	"test still failing because client/provider methods are not tagged"
	self assert: (self m1 allProvidersIn: {self tag2}) size equals: 1.
	self assert: (self m1 allProvidersIn: {self compositeTag2}) size equals: 1
]

{ #category : 'tests' }
FamixTaggingDependencyDetectorTest >> testProviderTagToClasses [
	"When asking all providers of a tag we should have the result of all providers for all tagged entities."

	self createTags.
	self assertCollection: (self tag1 allProvidersIn: {self m1 . self m2} forModel: model) hasSameElements: {self m2}.
	self assertCollection: (self compositeTag1 allProvidersIn: {self m1 . self m2} forModel: model) hasSameElements: {self m2}
]
