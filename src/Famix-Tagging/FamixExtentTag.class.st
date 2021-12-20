"
I am Tags defined in extent, i.e. by a list of entities to which I apply.

I use `FamixTagAssociation` to represent the link between me and the tagged entities.

"
Class {
	#name : #FamixExtentTag,
	#superclass : #FamixTag,
	#category : #'Famix-Tagging-Model'
}

{ #category : #iterating }
FamixExtentTag >> allEntitiesRecursivelyIn: aMooseModel [
	"Compute _set_ of all entities in the tag and its sub-tags"

	^ (self taggedEntitiesInModel: aMooseModel) asSet
		addAll: (self subTags flatCollect: [ :each | each allEntitiesRecursivelyIn: aMooseModel ]);
		yourself
]

{ #category : #iterating }
FamixExtentTag >> allEntitiesRecursivelyIn: aMooseModel collect: aBlockOrSelector [
	"apply aSelector on all entities of the tag and recursively on all its sub-tags"

	^ (self allEntitiesRecursivelyIn: aMooseModel) collect: [ :each | aBlockOrSelector value: each ]
]

{ #category : #iterating }
FamixExtentTag >> allEntitiesRecursivelyIn: aMooseModel flatCollect: aBlockOrSelector [
	"apply aSelector on all entities of the tag and recursively on all its sub-tags"

	^ (self allEntitiesRecursivelyIn: aMooseModel) flatCollect: [ :each | aBlockOrSelector value: each ]
]

{ #category : #accessing }
FamixExtentTag >> allTaggedEntitiesInModel: aModel [
	^ (self allSubTags flatCollectAsSet: [ :tag | tag taggedEntitiesInModel: aModel ])
		addAll: (self taggedEntitiesInModel: aModel);
		yourself
]

{ #category : #removing }
FamixExtentTag >> deleteAssociationsInModel: aMooseModel [
	(aMooseModel associationsForTag: self) do: #remove
]

{ #category : #dependencies }
FamixExtentTag >> isInListOfPossibleLinks: aCollection forModel: aMooseModel [
	^ aCollection includesAny: (self allTaggedEntitiesInModel: aMooseModel)
]

{ #category : #dependencies }
FamixExtentTag >> isLinkedTo: aTagOrEntity dependancyDirection: aDirectionStrategy in: aMooseModel [
	| dependencies |
	dependencies := self allEntitiesRecursivelyIn: aMooseModel flatCollect: [ :entity | aDirectionStrategy dependenciesAtReceiverScopeOf: entity ].

	"In the entity is a MooseEntity, with check if it is in its dependencies. 
	If it is a tag, we look in the tags of its dependencies and the parents of those tags."
	^ (aTagOrEntity isTag
		ifTrue: [ dependencies flatCollectAsSet: [ :entity | entity tags , (entity tags flatCollect: #allParentTags) ] ]
		ifFalse: [ dependencies ]) includes: aTagOrEntity
]

{ #category : #actions }
FamixExtentTag >> mergeWith: anotherTag forModel: aModel [
	(aModel associationsForTag: anotherTag) do: [ :aTagAssociation | aTagAssociation tag: self ].
	anotherTag allSubTags copy
		do: [ :tag | 
			[ tag changeParentTagTo: self ]
				on: FamixAlreadyExistTagFailure
				do: [ :anException | anException existingTag mergeWith: tag forModel: aModel ] ].
	anotherTag remove
]

{ #category : #removing }
FamixExtentTag >> removeAndDeleteAssociationsInModel: aMooseModel [
	self subTags copy do: [ :aSubTag | aSubTag removeAndDeleteAssociationsInModel: aMooseModel ].
	self deleteAssociationsInModel: aMooseModel.
	self remove
]

{ #category : #accessing }
FamixExtentTag >> taggedEntities [
	"Should only use that if you store tag and entities in the same model"

	^ self taggedEntitiesInModel: self mooseModel
]

{ #category : #accessing }
FamixExtentTag >> taggedEntitiesInModel: aModel [
	^ aModel entitiesTaggedWith: self
]
