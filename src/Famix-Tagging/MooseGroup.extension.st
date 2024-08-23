Extension { #name : #MooseGroup }

{ #category : #'*Famix-Tagging' }
MooseGroup >> allTaggedEntities [
	self entities flatCollectAsSet: #allTaggedEntities.
]

{ #category : #'*Famix-Tagging' }
MooseGroup >> tagEntitiesWith: aTag [

	self do: [ :e | e tagWith: aTag ]
]

{ #category : #'*Famix-Tagging' }
MooseGroup >> tagEntitiesWithName: aTagName [

	self do: [ :e | e tagWithName: aTagName ]
]
