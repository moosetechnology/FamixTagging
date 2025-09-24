Extension { #name : 'MooseModel' }

{ #category : '*Famix-Tagging' }
MooseModel >> addTaggingEntityFirst: anElement [
	"Since we can add and remove tags a lot, we prefer to have it at the start of the entity storage. Also, we do not want to flush all caches but only the ones related to tags."

	self entityStorage addTaggingEntityFirst: anElement.
	self removeTagProperties.
	anElement privateSetMooseModel: self.
	self announcer announce: (MooseEntityAdded new entity: anElement).
	^ anElement
]

{ #category : '*Famix-Tagging' }
MooseModel >> allTaggedEntities [

	^ self allTagAssociations collect: [ :assoc | assoc entity ] as: Set
]

{ #category : '*Famix-Tagging' }
MooseModel >> copyTag: foreignTag [
	"create a copy of foreignTag in receiver"

	| myTag |
	myTag ifNotNil: [^myTag].

	myTag := self createTagNamed: foreignTag name.
	myTag description: foreignTag description.
	myTag serializedColor: foreignTag serializedColor.
	myTag isHidden: foreignTag isHidden.

	foreignTag parentTag
		ifNotNil: [ myTag parentTag: (self ensureTagFrom: foreignTag parentTag) ].
		
	"- #categories ???"

	^myTag 
]

{ #category : '*Famix-Tagging' }
MooseModel >> ensureTagFrom: foreignTag [
	"if a tag with 'foreignTag name' does not exist, create it as a copy of foreignTag"

	^[ self findTagNamed: foreignTag name ]
		on: NotFound
		do: [ self copyTag: foreignTag ]

]

{ #category : '*Famix-Tagging' }
MooseModel >> importTagsFrom: otherModel [
	"Recreate all tags from a 'foreign' model:
	 - create the tags with same properties
	 - try to set the tags on my entities based on the mooseName of the tagged entities in the otherModel"

	otherModel allTags do: [ :foreignTag || myTag |
		myTag := self ensureTagFrom: foreignTag.
		(foreignTag allTaggedEntitiesInModel: otherModel) do: [ :foreignEntity |
			self tagEntityNamed: foreignEntity mooseName with: myTag]
	]
]

{ #category : '*Famix-Tagging' }
MooseModel >> removeTagProperties [
	"I am used when we remove tags to update the caches"

	cache keysAndValuesRemove: [ :key :value | key asString includesSubstring: 'FamixTag' ]
]

{ #category : '*Famix-Tagging' }
MooseModel >> removeTaggingEntity: anElement [
	"Do not flush all caches because we detag something."

	self entityStorage remove: anElement.
	anElement privateSetMooseModel: nil.
	self removeTagProperties.
	self announcer announce: (MooseEntityRemoved new entity: anElement).
	^ anElement
]

{ #category : '*Famix-Tagging' }
MooseModel >> tagEntityNamed: aMooseName with: myTag [

	self
		entityNamed: aMooseName
		ifAbsent: [ "ignore" ]
		ifPresent: [ :entity | entity tagWith:myTag ]
]
