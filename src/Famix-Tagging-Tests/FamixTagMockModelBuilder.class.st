"
Builds a FAMIX model for testing tags on moose entities
"
Class {
	#name : #FamixTagMockModelBuilder,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Famix-Tagging-Tests'
}

{ #category : #'model-building' }
FamixTagMockModelBuilder class >> buildComplexModel [

	^ self new buildComplexModel
]

{ #category : #running }
FamixTagMockModelBuilder class >> buildModel [
	^self new buildModel
]

{ #category : #running }
FamixTagMockModelBuilder class >> buildModelWithoutTags [
	^ self new simpleModel; model
]

{ #category : #'model-building' }
FamixTagMockModelBuilder >> buildCodeTag [
	| entity |
	entity := self entityToTag.
	(FamixTag named: 'dead-code')
		description: 'Not used code';
		color: Color red;
		addCategory: ((FamixTagCategory named: 'bookmark') mooseModel: self model);
		mooseModel: self model;
		tagInterval: (10 to: 300) forEntity: entity sourceAnchor: entity sourceAnchor
]

{ #category : #'model-building' }
FamixTagMockModelBuilder >> buildComplexModel [

	| package fooClass factoryClass dataAttribute dataSetter makeFooMethod tag1 tag2 |
	model := FamixTagTestModel new.

	package := model newPackageNamed: 'Foo-Core'.
	package types: {
			(fooClass := model newClassNamed: 'Foo').
			(factoryClass := model newClassNamed: 'FooFactory') }.

	"Foo.data"
	dataAttribute := model newAttributeNamed: 'data'.
	dataAttribute parentType: fooClass.

	"Foo >> #data:"
	dataSetter := model newMethodNamed: 'data:'.
	dataSetter parentType: fooClass.
	dataSetter accesses: { (model newAccess variable: dataAttribute) }.

	"FooFactory >> #makeFooWith:"
	makeFooMethod := model newMethodNamed: 'makeFooWith:'.
	makeFooMethod parentType: factoryClass.
	makeFooMethod outgoingInvocations: {
			(model newInvocation receiver: fooClass).
			(model newInvocation candidates: { dataSetter }) }.

	"create and set tags"
	tag1 := model addTaggingEntityFirst: (FamixTag named: 'tag1').
	tag1 tagEntity: package.
	tag1 tagEntity: fooClass.
	tag1 tagEntity: dataSetter incomingInvocations first.
	tag1 tagEntity: dataAttribute.

	tag2 := model addTaggingEntityFirst: (FamixTag named: 'tag2').
	tag2 tagEntity: fooClass.
	tag2 tagEntity: dataSetter accesses first.
	tag2 tagEntity: makeFooMethod.

	^ model
]

{ #category : #'model-building' }
FamixTagMockModelBuilder >> buildModel [
	self simpleModel.
	self buildTags.
	^ model
]

{ #category : #'model-building' }
FamixTagMockModelBuilder >> buildTag [
	(FamixTag named: 'database')
		description: 'Implements database functionality';
		color: Color green;
		addCategory: ((FamixTagCategory named: 'feature') mooseModel: self model);
		mooseModel: self model;
		tagEntity: self entityToTag
]

{ #category : #'model-building' }
FamixTagMockModelBuilder >> buildTags [
	self buildCodeTag.
	self buildTag.
]

{ #category : #helpers }
FamixTagMockModelBuilder >> createEntitiesFor: counter [
	(FamixTagTestClass named: 'Class' , counter asString model: model)
		typeContainer: (FamixTagTestPackage named: 'Package' , counter asString model: model);
		sourceAnchor:
			(FamixTagTestSourceTextAnchor new
				source: self sourceText;
				mooseModel: model;
				yourself)
]

{ #category : #helpers }
FamixTagMockModelBuilder >> entityToTag [
	^ model entityNamed: 'Package1::Class1'
]

{ #category : #helpers }
FamixTagMockModelBuilder >> model [
	^ model
]

{ #category : #'model-building' }
FamixTagMockModelBuilder >> simpleModel [
	model := FamixTagTestModel named: 'Tagging-Model'.
	self
		createEntitiesFor: 1;
		createEntitiesFor: 2
]

{ #category : #helpers }
FamixTagMockModelBuilder >> sourceText [
	^ '// HelloWorld.java

public class HelloWorld {
	public static void main(String[] args) {
		System.out.println("Hello World!");
	}
}'
]
