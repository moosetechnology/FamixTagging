"
This trait is used by Famix models.
It provides an API for creating entities and adding them to the model.
"
Trait {
	#name : #FamixTagTestTEntityCreator,
	#category : #'Famix-Tagging-Tests-Entities-Model'
}

{ #category : #meta }
FamixTagTestTEntityCreator classSide >> annotation [

	<FMClass: #TEntityCreator super: #Object>
	<package: #'Famix-Tagging-Tests-Entities'>
	<generated>
	^ self
]

{ #category : #'entity creation' }
FamixTagTestTEntityCreator >> newAccess [

	<generated>
	^ self add: FamixTagTestAccess new
]

{ #category : #'entity creation' }
FamixTagTestTEntityCreator >> newAttribute [

	<generated>
	^ self add: FamixTagTestAttribute new
]

{ #category : #'entity creation' }
FamixTagTestTEntityCreator >> newAttributeNamed: aName [

	<generated>
	^ self add: (FamixTagTestAttribute named: aName)
]

{ #category : #'entity creation' }
FamixTagTestTEntityCreator >> newClass [

	<generated>
	^ self add: FamixTagTestClass new
]

{ #category : #'entity creation' }
FamixTagTestTEntityCreator >> newClassNamed: aName [

	<generated>
	^ self add: (FamixTagTestClass named: aName)
]

{ #category : #'entity creation' }
FamixTagTestTEntityCreator >> newInvocation [

	<generated>
	^ self add: FamixTagTestInvocation new
]

{ #category : #'entity creation' }
FamixTagTestTEntityCreator >> newMethod [

	<generated>
	^ self add: FamixTagTestMethod new
]

{ #category : #'entity creation' }
FamixTagTestTEntityCreator >> newMethodNamed: aName [

	<generated>
	^ self add: (FamixTagTestMethod named: aName)
]

{ #category : #'entity creation' }
FamixTagTestTEntityCreator >> newPackage [

	<generated>
	^ self add: FamixTagTestPackage new
]

{ #category : #'entity creation' }
FamixTagTestTEntityCreator >> newPackageNamed: aName [

	<generated>
	^ self add: (FamixTagTestPackage named: aName)
]

{ #category : #'entity creation' }
FamixTagTestTEntityCreator >> newSourceTextAnchor [

	<generated>
	^ self add: FamixTagTestSourceTextAnchor new
]
