Class {
	#name : 'FamixTagImportFromModelTest',
	#superclass : 'TestCase',
	#instVars : [
		'model1',
		'model2'
	],
	#category : 'Famix-Tagging-Tests',
	#package : 'Famix-Tagging-Tests'
}

{ #category : 'running' }
FamixTagImportFromModelTest >> setUp [
	| class |
	super setUp.

	model1 := FamixTagTestModel new.
	class := model1 newClassNamed: 'AClass'.
	(model1 newMethodNamed: 'm1') parentType: class.
	(model1 newMethodNamed: 'm2') parentType: class.

	model2 := FamixTagTestModel new.
	class := model2 newClassNamed: 'AClass'.
	(model2 newMethodNamed: 'm1') parentType: class.
	(model2 newMethodNamed: 'm2') parentType: class.

]

{ #category : 'tests' }
FamixTagImportFromModelTest >> testCopyParentTag [

	| tagOrigin childTag |
	tagOrigin := model1 tagNamed: 'childTag'.
	tagOrigin parentTag: (model1 tagNamed: 'rootTag').

	self assert: model2 allTags isEmpty.

	model2 copyTag: tagOrigin.

	self assert: model2 allTags size equals: 2.
	model2 allTags detect: [ :t | t name = 'childTag' ] ifNone: [ self fail ].
	model2 allTags detect: [ :t | t name = 'rootTag' ] ifNone: [ self fail ].

	childTag := model2 allTags detect: [ :t | t name = 'childTag' ].
	self assert: childTag parentTag isNotNil.
	self assert: childTag parentTag name equals: 'rootTag'.
	self assert: childTag parentTag mooseModel equals: model2.
]

{ #category : 'tests' }
FamixTagImportFromModelTest >> testCopyTag [

	| tagOrigin |
	tagOrigin := model1 tagNamed: 'aTag'.
	tagOrigin color: Color blue.
	tagOrigin description: 'tag to be copied'.

	self assert: model2 allTags isEmpty.

	model2 copyTag: tagOrigin.

	self assert: model2 allTags size equals: 1.
	self assert: model2 allTags anyOne name equals: 'aTag'.
	self assert: model2 allTags anyOne serializedColor equals: '0000FF'.  "blue"
	self assert: model2 allTags anyOne description equals: 'tag to be copied'.
]

{ #category : 'tests' }
FamixTagImportFromModelTest >> testEnsureAbsentTag [

	| tagOrigin |
	tagOrigin := model1 tagNamed: 'aTag'.
	tagOrigin color: Color blue.

	self assert: model2 allTags isEmpty.

	model2 ensureTagFrom: tagOrigin.

	self assert: model2 allTags size equals: 1.
	self assert: model2 allTags anyOne name equals: 'aTag'.
	self assert: model2 allTags anyOne serializedColor equals: '0000FF'.  "blue"
]

{ #category : 'tests' }
FamixTagImportFromModelTest >> testEnsureExistingTag [
	"Existing tags are not recreated"

	| tagOrigin |
	tagOrigin := model1 tagNamed: 'aTag'.
	tagOrigin color: Color blue.

	(model2 tagNamed: 'aTag')
		color: Color red.

	self assert: model2 allTags size equals: 1.

	model2 ensureTagFrom: tagOrigin.

	self assert: model2 allTags size equals: 1.
	self assert: model2 allTags anyOne name equals: 'aTag'.
	self assert: model2 allTags anyOne serializedColor equals: 'FF0000'.  "red"
]

{ #category : 'tests' }
FamixTagImportFromModelTest >> testImportTagsFrom [

	| tagCopy |
	(model1 allMethods detect: [ :m | m name = 'm1' ])
		tagWithName: 'aTag'.

	self assert: model2 allTags isEmpty.

	model2 importTagsFrom: model1.

	self assert: model2 allTags size equals: 1.
	tagCopy := model2 allTags anyOne.
	self assert: tagCopy name equals: 'aTag'.
	self assert: tagCopy taggedEntities size equals: 1.
	self assert: tagCopy taggedEntities anyOne equals: (model2 allMethods detect: [ :m | m name = 'm1' ]).
]

{ #category : 'tests' }
FamixTagImportFromModelTest >> testTagEntityNamedWith [

	| tag mth |
	tag := model2 tagNamed: 'aTag'.
	mth := model2 allMethods detect: [ :m | m name = 'm1' ].

	self assert: mth allTags isEmpty.

	model2 tagEntityNamed: 'AClass.m1' with: tag.

	self assert: mth allTags size equals: 1.
	self assert: mth allTags anyOne name equals: 'aTag'
]
