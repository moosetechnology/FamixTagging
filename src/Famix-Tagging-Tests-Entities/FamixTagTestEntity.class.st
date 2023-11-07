Class {
	#name : #FamixTagTestEntity,
	#superclass : #MooseEntity,
	#category : #'Famix-Tagging-Tests-Entities-Entities'
}

{ #category : #meta }
FamixTagTestEntity class >> annotation [

	<FMClass: #Entity super: #MooseEntity>
	<package: #'Famix-Tagging-Tests-Entities'>
	<generated>
	<abstract>
	^ self
]

{ #category : #testing }
FamixTagTestEntity class >> isAbstract [

	<generated>
	^ self == FamixTagTestEntity
]

{ #category : #meta }
FamixTagTestEntity class >> metamodel [

	<generated>
	^ FamixTagTestModel metamodel
]

{ #category : #testing }
FamixTagTestEntity >> isAccess [

	<generated>
	^ false
]

{ #category : #testing }
FamixTagTestEntity >> isAssociation [

	<generated>
	^ false
]

{ #category : #testing }
FamixTagTestEntity >> isAttribute [

	<generated>
	^ false
]

{ #category : #testing }
FamixTagTestEntity >> isBehavioural [

	<generated>
	^ false
]

{ #category : #testing }
FamixTagTestEntity >> isClass [

	<generated>
	^ false
]

{ #category : #testing }
FamixTagTestEntity >> isInvocation [

	<generated>
	^ false
]

{ #category : #testing }
FamixTagTestEntity >> isMethod [

	<generated>
	^ false
]

{ #category : #testing }
FamixTagTestEntity >> isPackage [

	<generated>
	^ false
]

{ #category : #testing }
FamixTagTestEntity >> isStructuralEntity [

	<generated>
	^ false
]

{ #category : #testing }
FamixTagTestEntity >> isType [

	<generated>
	^ false
]
