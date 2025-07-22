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
