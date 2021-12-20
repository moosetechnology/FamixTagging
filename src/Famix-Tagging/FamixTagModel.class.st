"
I am a moose model for tags. I am separated from the MooseModel with MooseEntities because my tags can be applied to different MooseModels (for project versions, mutations...).

For this, there is no strong link between MooseEntities and the FamixTagModel
"
Class {
	#name : #FamixTagModel,
	#superclass : #MooseAbstractGroup,
	#category : #'Famix-Tagging-Model'
}

{ #category : #meta }
FamixTagModel class >> annotation [
	<FMClass: #TagModel super: #MooseAbstractGroup>
	<package: #Tagging>
]

{ #category : #'adding/removing' }
FamixTagModel >> add: anEntity [
	self
		assert: (anEntity class = FamixTag or: anEntity class = FamixTagCategory)
		description: 'Only FamixTag and FamixTagCategory can be added to a FamixTagModel'.
	super add: anEntity
]

{ #category : #'adding/removing' }
FamixTagModel >> addTaggingEntityFirst: anEntity [
	self add: anEntity
]

{ #category : #removing }
FamixTagModel >> removeTaggingEntity: aFamixTag [
	self removeEntity: aFamixTag
]
