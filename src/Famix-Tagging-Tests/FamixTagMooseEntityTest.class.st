Class {
	#name : 'FamixTagMooseEntityTest',
	#superclass : 'FamixTagMooseModelTest',
	#category : 'Famix-Tagging-Tests',
	#package : 'Famix-Tagging-Tests'
}

{ #category : 'tests' }
FamixTagMooseEntityTest >> testHasTag [
	| class1 tagDB |
	class1 := model allModelClasses detect: [ :c | c name = 'Class1' ].
	tagDB := model tags detect: [ :t | t name = 'database' ].
	self assert: (class1 hasTag: tagDB ).
]

{ #category : 'tests' }
FamixTagMooseEntityTest >> testHasTagNamed [
	| class1 |
	class1 := model allModelClasses detect: [ :c | c name = 'Class1' ].
	self assert: (class1 hasTagNamed: 'database' ).
]
