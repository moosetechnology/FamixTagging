Extension { #name : #MooseGroupStorage }

{ #category : #'*Famix-Tagging' }
MooseGroupStorage >> addTaggingEntityFirst: anElement [
	elements addFirst: anElement.
	^ anElement
]
