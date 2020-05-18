Extension { #name : #FamixDependencyDetectorTest }

{ #category : #'*Famix-Tagging-Tests' }
FamixDependencyDetectorTest >> compositeTag1 [
	^ self tagNamed: 'compositeTag1'
]

{ #category : #'*Famix-Tagging-Tests' }
FamixDependencyDetectorTest >> compositeTag2 [
	^ self tagNamed: 'compositeTag2'
]

{ #category : #'*Famix-Tagging-Tests' }
FamixDependencyDetectorTest >> createTags [
	| parentTag classTag |
	parentTag := model createTagNamed: 'compositeTag1'.
	classTag := model createTagNamed: 'classTag1'.
	classTag parentTag: parentTag.
	(model entityNamed: 'Class1') tagWith: classTag.
	parentTag := model createTagNamed: 'compositeTag2'.
	classTag := model createTagNamed: 'classTag2'.
	classTag parentTag: parentTag.
	(model entityNamed: 'Class2') tagWith: classTag
]

{ #category : #'*Famix-Tagging-Tests' }
FamixDependencyDetectorTest >> tag1 [
	^ self tagNamed: #classTag1
]

{ #category : #'*Famix-Tagging-Tests' }
FamixDependencyDetectorTest >> tag2 [
	^ self tagNamed: #classTag2
]

{ #category : #'*Famix-Tagging-Tests' }
FamixDependencyDetectorTest >> tagNamed: aString [
	^ model tags detect: [ :tag | tag name = aString ] ifNone: [ nil ]
]

{ #category : #'*Famix-Tagging-Tests' }
FamixDependencyDetectorTest >> testClientClassFromTags [
	self createTags.
	"not connected to its own tag"
	self assertCollection: (self c2 allClientsIn: {self tag1}) hasSameElements: {self tag1}.
	self assertCollection: (self c2 allClientsIn: {self compositeTag1}) hasSameElements: {self compositeTag1}
]

{ #category : #'*Famix-Tagging-Tests' }
FamixDependencyDetectorTest >> testClientClassOwnTags [
	self createTags.
	"not connected to its own tag"
	self assertEmpty: (self c2 allClientsIn: {self tag2}).
	self assertEmpty: (self c2 allClientsIn: {self compositeTag2})
]

{ #category : #'*Famix-Tagging-Tests' }
FamixDependencyDetectorTest >> testClientTagFromClasses [
	self createTags.
	"not connected to its own tag"
	self assertCollection: (self tag1 allClientsIn: {self m1 . self m2} forModel: model) hasSameElements: {self m2}.
	self assertCollection: (self compositeTag1 allClientsIn: {self m1 . self m2} forModel: model) hasSameElements: {self m2}
]

{ #category : #'*Famix-Tagging-Tests' }
FamixDependencyDetectorTest >> testProviderClassOwnTags [
	self createTags.
	"not connected to its own tag"
	self assertEmpty: (self c1 allProvidersIn: {self tag1}).
	self assertEmpty: (self c1 allProvidersIn: {self compositeTag1})
]

{ #category : #'*Famix-Tagging-Tests' }
FamixDependencyDetectorTest >> testProviderClassToTags [
	self createTags.
	"not connected to its own tag"
	self assertCollection: (self c1 allProvidersIn: {self tag2}) hasSameElements: {self tag2}.
	self assertCollection: (self c1 allProvidersIn: {self compositeTag2}) hasSameElements: {self compositeTag2}
]

{ #category : #'*Famix-Tagging-Tests' }
FamixDependencyDetectorTest >> testProviderMethodToTags [
	<expectedFailure>
	self createTags.
	self flag: #TODO.	"test still failing because client/provider methods are not tagged"
	self assert: (self m1 allProvidersIn: {self tag2}) size equals: 1.
	self assert: (self m1 allProvidersIn: {self compositeTag2}) size equals: 1
]

{ #category : #'*Famix-Tagging-Tests' }
FamixDependencyDetectorTest >> testProviderTagToClasses [
	"When asking all providers of a tag we should have the result of all providers for all tagged entities."

	self createTags.
	self assertCollection: (self tag1 allProvidersIn: {self m1 . self m2} forModel: model) hasSameElements: {self m2}.
	self assertCollection: (self compositeTag1 allProvidersIn: {self m1 . self m2} forModel: model) hasSameElements: {self m2}
]
