Class {
	#name : 'FamixTagMooseGroupTest',
	#superclass : 'TestCase',
	#instVars : [
		'model'
	],
	#category : 'Famix-Tagging-Tests',
	#package : 'Famix-Tagging-Tests'
}

{ #category : 'running' }
FamixTagMooseGroupTest >> setUp [

	super setUp.
	model := FamixTagMockModelBuilder buildModel
]

{ #category : 'tests' }
FamixTagMooseGroupTest >> testTagMooseGroup [

	| mooseGroup tag |
	mooseGroup := model allModelClasses.
	tag := model tagNamed: 'myTag'.
	mooseGroup tagEntitiesWith: tag.
	
	self assert: (mooseGroup first hasTagNamed: 'myTag').
	self assert: (mooseGroup second hasTagNamed: 'myTag')
	
]

{ #category : 'tests' }
FamixTagMooseGroupTest >> testTagMooseGroupWithName [

	| mooseGroup |
	mooseGroup := model allModelClasses.
	
	mooseGroup tagEntitiesWithName: 'myTag'.
	
	self assert: (mooseGroup first hasTagNamed: 'myTag').
	self assert: (mooseGroup second hasTagNamed: 'myTag')
	
]
