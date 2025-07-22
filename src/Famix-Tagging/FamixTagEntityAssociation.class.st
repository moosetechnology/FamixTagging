"
Description
--------------------

I represent a one-to-one relationship object between a tag and an entity on which the tag is placed.

"
Class {
	#name : 'FamixTagEntityAssociation',
	#superclass : 'FamixTagAssociation',
	#category : 'Famix-Tagging-Model',
	#package : 'Famix-Tagging',
	#tag : 'Model'
}

{ #category : 'meta' }
FamixTagEntityAssociation class >> annotation [
	<FMClass: #EntityAssociation super: #FamixTagAssociation>
	<package: #Tagging>
]

{ #category : 'testing' }
FamixTagEntityAssociation >> isEntityTagAssociation [
	^ true
]
