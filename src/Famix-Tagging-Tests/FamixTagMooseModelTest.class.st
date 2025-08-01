Class {
	#name : 'FamixTagMooseModelTest',
	#superclass : 'TestCase',
	#instVars : [
		'model'
	],
	#category : 'Famix-Tagging-Tests',
	#package : 'Famix-Tagging-Tests'
}

{ #category : 'accessing' }
FamixTagMooseModelTest >> getClass1InModel: aModel [

	^ aModel entityNamed: 'Package1.Class1'
]

{ #category : 'running' }
FamixTagMooseModelTest >> setUp [
	super setUp.
	model := FamixTagMockModelBuilder buildModel
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testAddANewTagWithCategory [
	| oldSize |
	oldSize := model tags size.
	(model tagNamed: 'myTag') addCategoryNamed: 'false-positive'.
	self assert: model tags size equals: oldSize + 1.

	(model tagNamed: 'myTag') addCategoryNamed: 'false-positive'.
	self deny: model tags size equals: oldSize + 2
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testAllModelTags [
	self assert: model tags size equals: 2
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testAllRootTags [
	| tag1 tag2 tag3 |
	model := FamixTagModel new.
	tag1 := model createTagNamed: 'Furry'.
	tag2 := model createTagNamed: 'Bronie'.
	tag3 := model createTagNamed: 'Scalie'.

	tag2 parentTag: tag1.

	self assertCollection: model allRootTags hasSameElements: {tag1 . tag3}
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testAllRootTagsWithHiddenTags [
	| tag1 tag2 tag3 |
	model := FamixTagModel new.
	tag1 := model createTagNamed: 'Furry'.
	tag2 := model createTagNamed: 'Bronie'.
	tag3 := model createTagNamed: 'Scalie'.

	tag2 parentTag: tag1.
	tag3 hide.

	self assertCollection: model allRootTags hasSameElements: {tag1 . tag3}
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testAllTagAssociations [
	self assert: model allTagAssociations size equals: 2.

	model tags first hide.

	self assert: model allTagAssociations size equals: 2
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testAllTaggedEntities [

	self
		assertCollection: model allTaggedEntities
		hasSameElements: { (self getClass1InModel: model) }.

	"more complex model with multiple tags at different levels"
	model := FamixTagMockModelBuilder buildComplexModel.

	"on a model"
	self
		assertCollection: model allTaggedEntities
		hasSameElements: (model select: [ :entity | entity isTagged ]).

	"on an entity"
	self
		assertCollection: (model entityNamed: #'Foo-Core.Foo') allTaggedEntities
		hasSameElements: {
				(model entityNamed: 'Foo-Core.Foo').
				(model entityNamed: #'Foo-Core.Foo.data') }
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testAllTags [
	| tag1 tag2 tag3 |
	model := FamixTagModel new.
	tag1 := model createTagNamed: 'Furry'.
	tag2 := model createTagNamed: 'Bronie'.
	tag3 := model createTagNamed: 'Scalie'.

	tag2 parentTag: tag1.

	self assertCollection: model allTags hasSameElements: {tag1 . tag2. tag3}
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testAllTagsWithHiddenTags [
	| tag1 tag2 tag3 |
	model := FamixTagModel new.
	tag1 := model createTagNamed: 'Furry'.
	tag2 := model createTagNamed: 'Bronie'.
	tag3 := model createTagNamed: 'Scalie'.

	tag2 parentTag: tag1.
	tag3 hide.

	self assertCollection: model allTags hasSameElements: {tag1 . tag2 . tag3}
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testClassicCachesAreNotResetWhenAddingATag [
	"When using tags we do not want to invalidate model caches all the time. Only the ones relative to tags."

	model cacheAt: #fursona put: #jecisc.

	model createTagNamed: 'NewTag'.

	model cacheAt: #fursona ifAbsent: [ self fail ]
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testClassicCachesAreNotResetWhenEntityWasTagged [
	"When using tags we do not want to invalidate model caches all the time. Only the ones relative to tags."

	model cacheAt: #fursona put: #jecisc.

	(model entityNamed: 'Package2') tagWithName: 'dead-code'.

	model cacheAt: #fursona ifAbsent: [ self fail ]
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testClassicCachesAreNotResetWhenEntityWasUntagged [
	"When using tags we do not want to invalidate model caches all the time. Only the ones relative to tags."

	model cacheAt: #fursona put: #jecisc.

	(self getClass1InModel: model) removeTags.

	model cacheAt: #fursona ifAbsent: [ self fail ]
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testClassicCachesAreNotResetWhenRemovingATag [
	"When using tags we do not want to invalidate model caches all the time. Only the ones relative to tags."

	model cacheAt: #fursona put: #jecisc.

	model tags first remove.

	model cacheAt: #fursona ifAbsent: [ self fail ]
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testCodeTagAssociation [

	| interval |
	interval := model codeTagAssociations first.
	self assert: model codeTagAssociations size equals: 1.
	self assert: interval entity equals: (self getClass1InModel: model).
	self
		assert: interval tag
		equals:
		(self getClass1InModel: model) codeTagAssociations anyOne tag
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testCodeTags [
	self assert: model tags size equals: 2.
	self assert: model tags anyOne serializedColor equals: 'FF0000'
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testDetagEntityAssociation [

	| modelSize |
	modelSize := model size.
	model entityTagAssociations first remove.
	self assertEmpty: model entityTagAssociations.
	self assert: model size equals: modelSize - 1.
	self assertEmpty:
		(self getClass1InModel: model) entityTagAssociations.
	self
		assert: (self getClass1InModel: model) codeTagAssociations size
		equals: 1
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testDetagIntervalAssociation [

	| modelSize |
	modelSize := model size.
	model codeTagAssociations anyOne remove.
	self assertEmpty: model codeTagAssociations.
	self assert: model size equals: modelSize - 1.
	self assertEmpty: (self getClass1InModel: model) codeTagAssociations.
	self
		assert: (self getClass1InModel: model) entityTagAssociations size
		equals: 1
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testEntityTagAssociation [

	self
		assert: (self getClass1InModel: model) entityTagAssociations size
		equals: 1
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testExportImportChildren [
	| importedModel file |
	model := FamixTagTestModel new.
	model add: ((FamixTag named: 'parent') subTags: {(FamixTag named: 'child1') . (FamixTag named: 'child2')}).
	model addAll: (model tags detect: #isComposite) subTags.

	file := FileSystem memory / 'tmp'.
	file writeStreamDo: [ :str | model exportToMSEStream: str ].

	importedModel := file
		readStreamDo: [ :s | 
			"Do not enable the checks during tag import from MSE since they'll be in a random order"
			[ FamixTagTestModel new importFromMSEStream: s ]
				on: FamixTagFailure
				do: [ :ex | ex resume ] ].
	self assert: (importedModel tags detect: #isComposite) subTags size equals: 2
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testNoCategoryAddTag [
	| myModel |
	myModel := FamixTagTestModel new.
	2 timesRepeat: [ myModel tagNamed: 'something' ].
	self assert: myModel tags size equals: 1
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testNumberPackages [
	self assert: model allModelPackages size equals: 2
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testRetrievalFromModelWithCategories [
	self assert: (model tagCategoryNamed: 'feature') markedTags size equals: 1.
	self assertEmpty: (model tagCategoryNamed: 'default') markedTags
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testRootTags [
	| tag1 tag2 tag3 |
	model := FamixTagModel new.
	tag1 := model createTagNamed: 'Furry'.
	tag2 := model createTagNamed: 'Bronie'.
	tag3 := model createTagNamed: 'Scalie'.

	tag2 parentTag: tag1.
	tag3 hide.

	self assertCollection: model rootTags hasSameElements: {tag1}
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testTagAssociations [
	self assert: model tagAssociations size equals: 2.

	model tags first hide.

	self assert: model tagAssociations size equals: 1
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testTagCachesAreResetWhenAddingATag [
	self assert: model tags size equals: 2.

	model createTagNamed: 'NewTag'.

	self assert: model tags size equals: 3
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testTagCachesAreResetWhenEntityWasTagged [
	self assert: model entityTagAssociations size equals: 1.

	(model entityNamed: 'Package2') tagWithName: 'dead-code'.

	self assert: model entityTagAssociations size equals: 2
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testTagCachesAreResetWhenEntityWasUntagged [

	self assert: model entityTagAssociations size equals: 1.

	(self getClass1InModel: model) removeTags.

	self assertEmpty: model entityTagAssociations
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testTagCachesAreResetWhenRemovingATag [
	self assert: model tags size equals: 2.

	model tags first remove.

	self assert: model tags size equals: 1
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testTagDescription [
	self assert: model tags first description equals: 'Not used code'.
	self assert: model tags second description equals: 'Implements database functionality'
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testTagRemoval [
	| tag entity |
	tag := model tags first.
	entity := (model entitiesTaggedWith: tag) first.
	self assert: entity tagAssociations size equals: 2.
	self assert: model tags size equals: 2.
	tag remove.
	"we delete tagAssociations to the tag"
	self assert: entity tagAssociations size equals: 1.
	self assert: model tags size equals: 1
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testTaggedEntities [
	self assert: model tags first taggedEntities size equals: 1
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testTags [
	| entityTags |
	entityTags := model tags second.
	self assert: model tags size equals: 2.
	self assert: entityTags serializedColor equals: '00FF00'
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testTagsExportAndImportMSE [

	| importedModel interval importedTag tempFile |
	tempFile := (FileSystem memory / 'export-test.mse') ensureCreateFile.
	tempFile writeStreamDo: [ :stream | model exportToMSEStream: stream ].

	self assert: (model tagNamed: 'dead-code') color equals: Color red.

	importedModel := tempFile readStreamDo: [ :stream |
		                 FamixTagTestModel new importFromMSEStream: stream ].

	self assert: importedModel size equals: model size.
	self assert: importedModel codeTagAssociations size equals: 1.

	interval := importedModel codeTagAssociations first.

	self
		assert: interval entity
		equals: (self getClass1InModel: importedModel).
	self assert: interval tag serializedColor equals: 'FF0000'.
	self assert: interval tag description equals: 'Not used code'.

	importedTag := importedModel tagNamed: 'dead-code'.

	self assert: interval tag equals: importedTag.
	self assert: interval tag categories first name equals: 'bookmark'.
	self assert: importedTag name equals: 'dead-code'.
	self assert: importedTag description equals: 'Not used code'.
	self
		assert: (importedModel tagNamed: 'database') description
		equals: 'Implements database functionality'.
	self
		assert:
		(self getClass1InModel: importedModel) codeTagAssociations size
		equals: 1.
	self
		assert:
		(self getClass1InModel: importedModel) entityTagAssociations size
		equals: 1
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testTagsWithHidden [
	| tag1 tag2 tag3 |
	model := FamixTagModel new.
	tag1 := model createTagNamed: 'Furry'.
	tag2 := model createTagNamed: 'Bronie'.
	tag3 := model createTagNamed: 'Scalie'.

	tag2 parentTag: tag1.
	tag3 hide.

	self assertCollection: model tags hasSameElements: {tag1 . tag2}
]

{ #category : 'tests' }
FamixTagMooseModelTest >> testToggleTag [
	| entity tag numberOfTag |
	entity := model allPackages anyOne.
	tag := model createTagNamed: 'TestToggleWithTag'.
	numberOfTag := entity tags size.
	entity toggleTag: tag.
	self assert: entity tags size equals: numberOfTag + 1.
	numberOfTag := entity tags size.
	entity toggleTag: tag.
	self assert: entity tags size equals: numberOfTag - 1.
	numberOfTag := entity tags size.
	entity toggleTag: tag.
	self assert: entity tags size equals: numberOfTag + 1
]
