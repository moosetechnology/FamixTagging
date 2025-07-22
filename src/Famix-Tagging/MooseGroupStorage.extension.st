Extension { #name : #MooseGroupStorage }

{ #category : #'*Famix-Tagging' }
MooseGroupStorage >> addTaggingEntityFirst: anElement [
	elements addFirst: anElement.
	self updateCacheOnAddingOf: anElement.
	^ anElement
]
