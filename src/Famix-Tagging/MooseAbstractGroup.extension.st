Extension { #name : 'MooseAbstractGroup' }

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> allEntityTagAssociations [
	"All entity tags placed on this entity"

	^ self allWithType: FamixTagEntityAssociation
]

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> allRootTags [
	^ self allTags select: #isRoot
]

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> allTagAssociations [
	<navigation: 'All tag associations stored in this model'>
	^ self allWithSubTypesOf: FamixTagAssociation
]

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> allTagCategories [
	<navigation: 'All tag categories stored in this model'>
	^ self allWithSubTypesOf: FamixTagCategory
]

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> allTags [
	<navigation: 'All simple or composite tags known by this model'>
	^ self allWithType: FamixTag
]

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> associationsForTag: aTag [
	| mn |
	mn := aTag mooseName.
	^ self allTagAssociations asOrderedCollection select: [ :each | each tag mooseName = mn ]
]

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> createTagCategoryNamed: aCategoryMooseName [
	^ (FamixTagCategory named: aCategoryMooseName)
		mooseModel: self;
		yourself
]

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> createTagNamed: aTagMooseName [
	^ [ FamixAlreadyExistTagFailure signalWithTag: (self findTagNamed: aTagMooseName) ]
		on: NotFound
		do: [ :err | 
			(FamixTag named: aTagMooseName)
				mooseModel: self;
				yourself ]
]

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> entitiesTaggedWith: aTag [
	^ (self associationsForTag: aTag) collect: #entity
	
]

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> entityTagAssociations [
	"All entity tags placed on this entity"

	^ self allEntityTagAssociations reject: #isHidden
]

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> exportTagsOn: aStream tagModel: aTagModel [
	FamixTagSTONWriter export: self with: aTagModel on: aStream
]

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> findEquivalentTagTo: aFamixTag [
	^ self allTags detect: [ :aTag | aTag equivalentTo: aFamixTag ]
]

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> findTagCategoryNamed: aCategoryMooseName [
	^ self allTagCategories detect: [ :anEntity | anEntity mooseName = aCategoryMooseName ]
]

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> findTagNamed: aTagMooseName [
	"we dont care about tag category"

	^ self allTags detect: [ :anEntity | anEntity mooseName = aTagMooseName ]
]

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> findTagWithId: aTagId [
	^ self allTags detect: [ :aTag | aTag id = aTagId ]
]

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> importTagsFrom: aStream tagModel: aTagModel [
	^ (FamixTagSTONReader on: aStream)
		tagModel: aTagModel;
		model: self;
		next;
		report
]

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> rootTags [
	^ self allRootTags reject: #isHidden
]

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> tagAssociations [
	<navigation: 'Visible tag associations stored in this model'>
	^ self allTagAssociations reject: #isHidden
]

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> tagCategoryNamed: aCategoryMooseName [
	^ [ self findTagCategoryNamed: aCategoryMooseName ]
		on: NotFound
		do: [ self createTagCategoryNamed: aCategoryMooseName ]
]

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> tagNamed: aTagMooseName [
	^ [ self findTagNamed: aTagMooseName ]
		on: NotFound
		do: [ self createTagNamed: aTagMooseName ]
]

{ #category : '*Famix-Tagging' }
MooseAbstractGroup >> tags [
	<navigation: 'All visible simple or composite tags known by this model'>
	^ self allTags reject: #isHidden
]
