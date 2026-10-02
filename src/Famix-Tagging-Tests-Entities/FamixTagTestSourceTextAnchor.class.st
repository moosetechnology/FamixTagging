"
## Relations
======================

### Other
| Relation | Origin | Opposite | Type | Comment |
|---|
| `element` | `FamixTSourceAnchor` | `sourceAnchor` | `FamixTSourceEntity` | Enable the accessibility to the famix entity that this class is a source pointer for|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `source` | `String` | nil | Actual source code of the source entity|

"
Class {
	#name : 'FamixTagTestSourceTextAnchor',
	#superclass : 'FamixTagTestEntity',
	#traits : 'FamixTHasImmediateSource',
	#classTraits : 'FamixTHasImmediateSource classTrait',
	#category : 'Famix-Tagging-Tests-Entities-Entities',
	#package : 'Famix-Tagging-Tests-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FamixTagTestSourceTextAnchor class >> annotation [

	<ignoreForCoverage>
	<FMClass: #SourceTextAnchor super: #FamixTagTestEntity>
	<package: #'Famix-Tagging-Tests-Entities'>
	<generated>
]
