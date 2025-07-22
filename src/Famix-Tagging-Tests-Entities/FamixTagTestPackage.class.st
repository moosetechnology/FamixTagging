Class {
	#name : 'FamixTagTestPackage',
	#superclass : 'FamixTagTestEntity',
	#traits : 'FamixTNamedEntity + FamixTPackage + FamixTWithTypes',
	#classTraits : 'FamixTNamedEntity classTrait + FamixTPackage classTrait + FamixTWithTypes classTrait',
	#category : 'Famix-Tagging-Tests-Entities-Entities',
	#package : 'Famix-Tagging-Tests-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FamixTagTestPackage class >> annotation [

	<FMClass: #Package super: #FamixTagTestEntity>
	<package: #'Famix-Tagging-Tests-Entities'>
	<generated>
	^ self
]
