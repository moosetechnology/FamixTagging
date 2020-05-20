Extension { #name : #MooseEntityState }

{ #category : #'*Famix-Tagging' }
MooseEntityState >> removeTagProperties [
	"I am used when we remove tags to update the caches"

	cache keysAndValuesRemove: [ :key :value | key asString includesSubstring: 'FamixTag' ]
]
