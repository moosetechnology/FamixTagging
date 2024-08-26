Extension { #name : #MooseEntity }

{ #category : #'*Famix-Tagging' }
MooseEntity >> allEntityTagAssociations [
	"All entity tag associations placed on this entity"

	^ self tagAssociations select: #isEntityTagAssociation
]

{ #category : #'*Famix-Tagging' }
MooseEntity >> allTagAssociations [
	<FMProperty: #allTagAssociations type: #FamixTagAssociation opposite: #entity>
	<multivalued>
	<FMComment: 'All the tag associations linking this entity to a Tag'>
	^ self attributeAt: #allTagAssociations ifAbsentPut: [ FMMultivalueLink on: self opposite: #entity: ]
]

{ #category : #'*Famix-Tagging' }
MooseEntity >> allTagAssociations: aCollection [
	self allTagAssociations value: aCollection
]

{ #category : #'*Famix-Tagging' }
MooseEntity >> allTaggedEntities [
	| taggedEntities |
	
	taggedEntities := OrderedCollection new.
	self allTaggedEntitiesIn: taggedEntities .
	^ taggedEntities .
	
]

{ #category : #'*Famix-Tagging' }
MooseEntity >> allTaggedEntitiesIn: anOrderedCollection [ 
	self isTagged ifTrue: [ anOrderedCollection add: self ].
	self children do: [ :c | c allTaggedEntitiesIn: anOrderedCollection ].
	^anOrderedCollection 
]

{ #category : #'*Famix-Tagging' }
MooseEntity >> allTags [
	"all tags on me"

	"
	
	self removeTags
	
	"

	^ (self allTagAssociations collectAsSet: #tag) asArray
]

{ #category : #'*Famix-Tagging' }
MooseEntity >> entityTagAssociations [
	"All entity tag associations placed on this entity"

	^ self allEntityTagAssociations reject: #isHidden
]

{ #category : #'*Famix-Tagging' }
MooseEntity >> hasTag: aTag [
	^ self tags includes: aTag
]

{ #category : #'*Famix-Tagging' }
MooseEntity >> hasTagNamed: aTagName [
	^ self tags anySatisfy:  [:aTag | aTag name = aTagName ].
]

{ #category : #'*Famix-Tagging' }
MooseEntity >> isTagged [
	<FMProperty: #isTagged type: #Boolean>
	<derived>
	<FMComment: 'Defines if the entity has at least one tag.'>
	^ self tagAssociations isNotEmpty
]

{ #category : #'*Famix-Tagging' }
MooseEntity >> isTaggedWith: aTag [
	self deprecated: 'Use #hasTag: instead.' transformWith: '``@object isTaggedWith: ``@aTag ' -> '``@object hasTag: ``@aTag '.
	^ self tags includes: aTag
]

{ #category : #'*Famix-Tagging' }
MooseEntity >> numberOfTags [
	"for queries, some times we want to search all entities that do not have any tags"

	<FMProperty: #numberOfTags type: #Number>
	<derived>
	<FMComment: 'Returns the number of tags present on the entity.'>
	^ self tags size
]

{ #category : #'*Famix-Tagging' }
MooseEntity >> removeTag: aTag [
	"remove a tag from this moose entity"

	self allTagAssociations detect: [ :assoc | assoc tag = aTag ] ifFound: #remove
]

{ #category : #'*Famix-Tagging' }
MooseEntity >> removeTags [
	self allTagAssociations asOrderedCollection do: #remove
]

{ #category : #'*Famix-Tagging' }
MooseEntity >> tagAssociations [
	^ self allTagAssociations reject: #isHidden
]

{ #category : #'*Famix-Tagging' }
MooseEntity >> tagWith: aTag [
	^ aTag tagEntity: self
]

{ #category : #'*Famix-Tagging' }
MooseEntity >> tagWithName: aTagName [
	"Use this method if you store your tags in your model"

	^ self tagWithName: aTagName tagModel: self mooseModel
]

{ #category : #'*Famix-Tagging' }
MooseEntity >> tagWithName: aTagName tagModel: aTagModel [
	^ self tagWith: (aTagModel tagNamed: aTagName)
]

{ #category : #'*Famix-Tagging' }
MooseEntity >> tags [
	^ self allTags reject: #isHidden
]

{ #category : #'*Famix-Tagging' }
MooseEntity >> tagsInModel: aTagModel [
	^ self tagAssociations collectAsSet: [ :assoc | assoc tagInTagModel: aTagModel ]
]

{ #category : #'*Famix-Tagging' }
MooseEntity >> toggleTag: aTag [
	"If the entity as already tagged with this tag, remove it. Else, tag the entity."

	self allTags
		detect: [ :tag | tag = aTag ]
		ifFound: [ :tag | self removeTag: tag ]
		ifNone: [ aTag tagEntity: self ]
]
