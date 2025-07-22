Class {
	#name : 'FamixTagTestClass',
	#superclass : 'FamixTagTestEntity',
	#traits : 'FamixTClass + FamixTSourceEntity',
	#classTraits : 'FamixTClass classTrait + FamixTSourceEntity classTrait',
	#category : 'Famix-Tagging-Tests-Entities-Entities',
	#package : 'Famix-Tagging-Tests-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FamixTagTestClass class >> annotation [

	<FMClass: #Class super: #FamixTagTestEntity>
	<package: #'Famix-Tagging-Tests-Entities'>
	<generated>
	^ self
]
