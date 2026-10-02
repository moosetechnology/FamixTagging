"
This trait is used by Famix models.
It provides an API for creating entities and adding them to the model.


"
Trait {
	#name : 'FamixTagTestTEntityCreator',
	#category : 'Famix-Tagging-Tests-Entities-Model',
	#package : 'Famix-Tagging-Tests-Entities',
	#tag : 'Model'
}

{ #category : 'meta' }
FamixTagTestTEntityCreator classSide >> annotation [

	<ignoreForCoverage>
	<FMClass: #TEntityCreator super: #Object>
	<package: #'Famix-Tagging-Tests-Entities'>
	<generated>
]

{ #category : 'entity creation' }
FamixTagTestTEntityCreator >> newAccess [

	<ignoreForCoverage>
	<generated>
	^ self add: FamixTagTestAccess new
]

{ #category : 'entity creation' }
FamixTagTestTEntityCreator >> newAttribute [

	<ignoreForCoverage>
	<generated>
	^ self add: FamixTagTestAttribute new
]

{ #category : 'entity creation' }
FamixTagTestTEntityCreator >> newAttributeNamed: aName [

	<ignoreForCoverage>
	<generated>
	^ self add: (FamixTagTestAttribute named: aName)
]

{ #category : 'entity creation' }
FamixTagTestTEntityCreator >> newClass [

	<ignoreForCoverage>
	<generated>
	^ self add: FamixTagTestClass new
]

{ #category : 'entity creation' }
FamixTagTestTEntityCreator >> newClassNamed: aName [

	<ignoreForCoverage>
	<generated>
	^ self add: (FamixTagTestClass named: aName)
]

{ #category : 'entity creation' }
FamixTagTestTEntityCreator >> newInvocation [

	<ignoreForCoverage>
	<generated>
	^ self add: FamixTagTestInvocation new
]

{ #category : 'entity creation' }
FamixTagTestTEntityCreator >> newMethod [

	<ignoreForCoverage>
	<generated>
	^ self add: FamixTagTestMethod new
]

{ #category : 'entity creation' }
FamixTagTestTEntityCreator >> newMethodNamed: aName [

	<ignoreForCoverage>
	<generated>
	^ self add: (FamixTagTestMethod named: aName)
]

{ #category : 'entity creation' }
FamixTagTestTEntityCreator >> newPackage [

	<ignoreForCoverage>
	<generated>
	^ self add: FamixTagTestPackage new
]

{ #category : 'entity creation' }
FamixTagTestTEntityCreator >> newPackageNamed: aName [

	<ignoreForCoverage>
	<generated>
	^ self add: (FamixTagTestPackage named: aName)
]

{ #category : 'entity creation' }
FamixTagTestTEntityCreator >> newSourceTextAnchor [

	<ignoreForCoverage>
	<generated>
	^ self add: FamixTagTestSourceTextAnchor new
]
