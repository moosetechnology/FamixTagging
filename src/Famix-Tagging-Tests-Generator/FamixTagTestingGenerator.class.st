Class {
	#name : #FamixTagTestingGenerator,
	#superclass : #FamixMetamodelGenerator,
	#instVars : [
		'method',
		'attribute',
		'access',
		'invocation',
		'class',
		'package',
		'entity',
		'sourceTextAnchor'
	],
	#category : #'Famix-Tagging-Tests-Generator'
}

{ #category : #accessing }
FamixTagTestingGenerator class >> packageName [
	^ #'Famix-Tagging-Tests-Entities'
]

{ #category : #accessing }
FamixTagTestingGenerator class >> prefix [
	^ #FamixTagTest
]

{ #category : #testing }
FamixTagTestingGenerator class >> shouldBeUpToDateInLatestMoose [
	^ false
]

{ #category : #accessing }
FamixTagTestingGenerator class >> submetamodels [
	^ {FamixGenerator}
]

{ #category : #definition }
FamixTagTestingGenerator >> defineClasses [
	super defineClasses.

	class := builder newClassNamed: #Class.
	method := builder newClassNamed: #Method.
	attribute := builder newClassNamed: #Attribute.
	access := builder newClassNamed: #Access.
	invocation := builder newClassNamed: #Invocation.
	package := builder newClassNamed: #Package.

	sourceTextAnchor := builder newClassNamed: #SourceTextAnchor.
]

{ #category : #definition }
FamixTagTestingGenerator >> defineHierarchy [

	super defineHierarchy.

	access --|> #TAccess.

	attribute --|> #TAttribute.

	class --|> #TClass.
	class --|> #TSourceEntity.

	invocation --|> #TInvocation.

	method --|> #TMethod.
	method --|> #TSourceEntity.

	package --|> #TPackage.
	package --|> #TWithTypes.
	package --|> #TNamedEntity.

	sourceTextAnchor --|> #THasImmediateSource
]
