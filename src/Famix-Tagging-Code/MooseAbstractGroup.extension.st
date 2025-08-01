Extension { #name : 'MooseAbstractGroup' }

{ #category : '*Famix-Tagging-Code' }
MooseAbstractGroup >> allCodeTagAssociations [
	"All entity tags placed on this entity"

	^ self allWithType: FamixTagCodeAssociation
]

{ #category : '*Famix-Tagging-Code' }
MooseAbstractGroup >> codeTagAssociations [
	"All entity tags placed on this entity"

	^ self allCodeTagAssociations reject: #isHidden
]
