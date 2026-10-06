Class {
	#name : 'FamixTagTestModel',
	#superclass : 'MooseModel',
	#traits : 'FamixTagTestTEntityCreator',
	#classTraits : 'FamixTagTestTEntityCreator classTrait',
	#category : 'Famix-Tagging-Tests-Entities-Model',
	#package : 'Famix-Tagging-Tests-Entities',
	#tag : 'Model'
}

{ #category : 'accessing' }
FamixTagTestModel class >> allSubmetamodelsPackagesNames [

	<ignoreForCoverage>
	<generated>
	^ #(#'Moose-Query' #'Famix-Traits')
]

{ #category : 'meta' }
FamixTagTestModel class >> annotation [

	<ignoreForCoverage>
	<FMClass: #Model super: #MooseModel>
	<package: #'Famix-Tagging-Tests-Entities'>
	<generated>
]
