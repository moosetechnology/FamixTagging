"
I can be associated with a tag to add semantic to it. For example, a tag that represents system architecture.
	
## Internal Representation and Key Implementation Points.

Instance Variables
- markedTags: <aCollection> The list of tags present in the category.
- name: <aString> The label of the category.

"
Class {
	#name : #FamixTagCategory,
	#superclass : #MooseEntity,
	#instVars : [
		'markedTags',
		'name'
	],
	#category : #'Famix-Tagging-Model'
}

{ #category : #meta }
FamixTagCategory class >> annotation [
	<FMClass: #Category super: #MooseEntity>
	<package: #Tagging>
]

{ #category : #ston }
FamixTagCategory class >> fromSton: aTagStonReader [
	| aTagCategory |
	aTagCategory := super fromSton: aTagStonReader.
	^ [ aTagStonReader tagModel findTagCategoryNamed: aTagCategory name ]
		on: NotFound
		do: [ 
			aTagCategory
				mooseModel: aTagStonReader tagModel;
				yourself ]
]

{ #category : #'instance creation' }
FamixTagCategory class >> named: aString [
	^ self new
		name: aString;
		yourself
]

{ #category : #ston }
FamixTagCategory class >> stonAllInstVarNames [
	^ super stonAllInstVarNames \ #(#mooseName #mooseID #cache #entityAttributes #mooseModel #markedTags)
]

{ #category : #adding }
FamixTagCategory >> addTag: aTag [
	self markedTags add: aTag
]

{ #category : #initialization }
FamixTagCategory >> initialize [
	super initialize.
	markedTags := FMMultiMultivalueLink on: self opposite: #categories
]

{ #category : #accessing }
FamixTagCategory >> markedTags [
	<FMProperty: #markedTags type: #FamixTag opposite: #categories> <multivalued> 
	<FMComment: 'tags this category is marking'>
	^ markedTags
]

{ #category : #accessing }
FamixTagCategory >> markedTags: anObject [
	markedTags value: anObject
]

{ #category : #accessing }
FamixTagCategory >> name [
	<FMProperty: #name type: #String>
	<FMComment: 'name of the category of the tag'>
	^ name
]

{ #category : #accessing }
FamixTagCategory >> name: anObject [
	name := anObject
]

{ #category : #ston }
FamixTagCategory >> stonContainSubObjects [
	^ false
]
