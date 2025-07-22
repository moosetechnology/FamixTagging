Class {
	#name : 'ManifestFamixTaggingCode',
	#superclass : 'PackageManifest',
	#category : 'Famix-Tagging-Code-Manifest',
	#package : 'Famix-Tagging-Code',
	#tag : 'Manifest'
}

{ #category : 'asserting' }
ManifestFamixTaggingCode class >> shouldBeIncludedByDefaultInMetamodelsWith: aCollectionOfPackages [
	^ aCollectionOfPackages anySatisfy: [ :package | package definedClasses anySatisfy: [ :class | class = FamixTSourceAnchor ] ]
]
