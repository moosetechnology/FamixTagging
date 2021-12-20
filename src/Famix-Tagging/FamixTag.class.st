"
I represent a concept that can be attached to MooseEntities. 

I may have multiple uses such as:
- Injecting human knowledge
- Bookmark entities
- Create subconcepts 
- Plan rearchitecture

Tags can be organized in categories: `FamixTagCategory`. 

Tags can be defined in _intent_ (a computable boolean function telling whether the tag applied to an entity) or in _extent_ (a list of entities to which the tag applies).
`FamixTagAssociation` represent the link between a tag and an entity.

Tags have an optional default color. Some visualizations that don't assign themselves colors to entities will use this default color to mark entities tagged.

Tags can contain other tags, if so, they are composite tags. 

## Internal Representation and Key Implementation Points.

Instance Variables
- categories: <aCollection> The list of categories a tag is included in.
- childrenTags: <aCollection> A collection of subtags. If it is not empty, this mean I am recursive.
- description: <aString> A string that is the description of the tag provided by the user.
- id: <aNumber> An id representing the tag. The association saves this ID to make the link with the tag in necessary.
- name: <aString> Name of the tag provided by the user.
- parentTag: <aFamixTag> The famix tag in which I am located. If nil, this mean that I am a root tag.
- serializedColor: <aString> Hex string representation of the tag's color. We save colors as string because Moose does not manage colors as part of the MM.

"
Class {
	#name : #FamixTag,
	#superclass : #MooseEntity,
	#instVars : [
		'name',
		'id',
		'description',
		'serializedColor',
		'parentTag',
		'categories',
		'subTags',
		'isHidden'
	],
	#category : #'Famix-Tagging-Model'
}

{ #category : #meta }
FamixTag class >> annotation [
	<FMClass: #Tag super: #MooseEntity>
	<package: #Tagging>
]

{ #category : #ston }
FamixTag class >> fromSton: aTagStonReader [
	| aTag |
	[ 
	aTag := super fromSton: aTagStonReader.
	^ [ aTagStonReader tagModel findEquivalentTagTo: aTag ]
		on: NotFound
		do: [ 
			aTag mooseModel: aTagStonReader tagModel.
			aTagStonReader report createdTag: aTag.
			aTag ] ]
		on: FamixAlreadyExistTagFailure
		do: [ :err | 
			aTagStonReader skipCurrentTag.
			^ err existingTag ]
]

{ #category : #display }
FamixTag class >> fuelIgnoredInstanceVariableNames [
    ^#('mooseID')
]

{ #category : #'instance creation' }
FamixTag class >> named: tagName [
	^ self new
		name: tagName;
		yourself
]

{ #category : #ston }
FamixTag class >> stonAllInstVarNames [
	^ super stonAllInstVarNames reject: [ :instVar | #(#mooseName #mooseID #cache #entityAttributes #mooseModel #subTags) includes: instVar ]
]

{ #category : #accessing }
FamixTag >> / aChildName [
	^ self subTagNamed: aChildName
]

{ #category : #accessing }
FamixTag >> addAllSubTagsIn: aCollection [
	aCollection addAll: self subTags.
	self subTags do: [ :each | each addAllSubTagsIn: aCollection ].
	^ aCollection
]

{ #category : #accessing }
FamixTag >> addCategory: aTagCategory [
	self categories add: aTagCategory
]

{ #category : #accessing }
FamixTag >> addCategoryNamed: aString [
	self categories
		add:
			(self mooseModel
				ifNil: [ FamixTagRequireModelFailure signal: 'The tag must be in a model to be associated to a category name' ]
				ifNotNil: [ self mooseModel tagCategoryNamed: aString ])
]

{ #category : #children }
FamixTag >> addSubTag: aTag [
	self checkChildValidity: aTag.
	self subTags add: aTag.
	aTag resetMooseName
]

{ #category : #dependencies }
FamixTag >> allClientsIn: aMooseGroup [
	"The tags should know in which model look for the tagged entities. Thus, #allClientsIn:forModel: should be used."

	^ self shouldNotImplement
]

{ #category : #accessing }
FamixTag >> allParentTags [
	^ self parentTag
		ifNil: [ #() ]
		ifNotNil: [ :tag | {tag} , tag allParentTags ]
]

{ #category : #dependencies }
FamixTag >> allProvidersIn: aMooseGroup [
	"The tags should know in which model look for the tagged entities. Thus, #allProvidersIn:forModel: should be used."

	^ self shouldNotImplement
]

{ #category : #accessing }
FamixTag >> allSubTags [
	^ self addAllSubTagsIn: OrderedCollection new
]

{ #category : #dependencies }
FamixTag >> canRecursivelyBeItsParent [
	^ true
]

{ #category : #accessing }
FamixTag >> categories [
	<FMProperty: #categories type: #FamixTagCategory opposite: #markedTags> <multivalued> 
	<FMComment: 'categories this tag is marked in'>
	^ categories
]

{ #category : #accessing }
FamixTag >> categories: anObject [
	categories value: anObject
]

{ #category : #accessing }
FamixTag >> changeParentTagTo: aTag [
	self parentTag: aTag
]

{ #category : #testing }
FamixTag >> checkChildValidity: aTag [
	aTag checkValidity.
	self subTags
		do: [ :aSubTag | 
			aSubTag name = aTag name
				ifTrue: [ FamixAlreadyExistTagFailure signalWithTag: aSubTag ] ]
]

{ #category : #testing }
FamixTag >> checkValidity [
	self name ifNil: [ FamixTagUnamedFailure signal ]
]

{ #category : #accessing }
FamixTag >> children [
	<FMProperty: #children type: #FamixTag >
	<multivalued>
	<derived>
	<FMComment: 'children tags of this composite tag'>
	^ self subTags 
]

{ #category : #accessing }
FamixTag >> color [
	^ Color fromHexString: self serializedColor
]

{ #category : #accessing }
FamixTag >> color: aColor [
	self serializedColor: aColor asHexString
]

{ #category : #children }
FamixTag >> createSubTagNamed: aString [
	^ (self class named: aString)
		parentTag: self;
		mooseModel: self mooseModel;
		yourself
]

{ #category : #children }
FamixTag >> createSubTagNamedWithoutCheck: aString [
	^ (self class named: aString)
		parentTag: self;
		mooseModelWithoutCheck: self mooseModel;
		yourself
]

{ #category : #accessing }
FamixTag >> description [
	<FMProperty: #description type: #String>
	<FMComment: 'Description for the tag'>
	^ description
]

{ #category : #accessing }
FamixTag >> description: aDescription [
	description := aDescription
]

{ #category : #dependencies }
FamixTag >> detectDependenciesUsing: aDetector [
	aDetector detectDependenciesFrom: aDetector potentialDependencies
]

{ #category : #comparing }
FamixTag >> equivalentTo: anotherEntity [
	^ self name = anotherEntity name
]

{ #category : #accessing }
FamixTag >> findSubTagNamed: aString [
	^ self children detect: [ :aChild | aChild name = aString ]
]

{ #category : #ston }
FamixTag >> fromSton: stonReader [
	stonReader parseMapDo: [ :instVarName :value | 
			| resolved |
			resolved := value isStonReference
				ifTrue: [ stonReader resolveReference: value ]
				ifFalse: [ value ].
			self perform: (instVarName , ':') asSymbol with: resolved ]
]

{ #category : #testing }
FamixTag >> hasCategory: aTagCategory [
	^ self categories includes: aTagCategory
]

{ #category : #testing }
FamixTag >> hasUniqueMooseNameInModel [
	^ true
]

{ #category : #accessing }
FamixTag >> hide [
	isHidden := true
]

{ #category : #accessing }
FamixTag >> id [
	<FMProperty: #id type: #Number>
	<FMComment: 'This id is unique and all associations point it'>
	^ id
]

{ #category : #accessing }
FamixTag >> id: anObject [
	id := anObject
]

{ #category : #initialization }
FamixTag >> initialize [
	super initialize.
	subTags := FMMultivalueLink on: self opposite: #parentTag:.
	categories := FMMultiMultivalueLink on: self opposite: #markedTags.

	id := UUIDGenerator default nextRandom16.
	self color: MDLColor randomColorAndTint.
	isHidden := false
]

{ #category : #accessing }
FamixTag >> isAncestorOf: aTag [
	aTag ifNil: [ ^ false ].

	aTag parentTag = self ifTrue: [ ^ true ].

	^ self isAncestorOf: aTag parentTag
]

{ #category : #testing }
FamixTag >> isComposite [
	^ self subTags isNotEmpty
]

{ #category : #accessing }
FamixTag >> isHidden [
	<FMProperty: #isHidden type: #Boolean>
	<FMComment: 'Flag true for tags that should not appear in the tools.'>
	^ isHidden
]

{ #category : #accessing }
FamixTag >> isHidden: anObject [
	isHidden := anObject
]

{ #category : #testing }
FamixTag >> isRoot [
	"A Root tag is a tag without parent that should be displayed at the first layer of a tree representation of a tag hierarchy."

	^ self parentTag isNil
]

{ #category : #testing }
FamixTag >> isTag [
	^ true
]

{ #category : #accessing }
FamixTag >> mooseModel: aMooseModel [
	self checkValidity.
	[ "We try here to find if there is an existing tag in the model" FamixAlreadyExistTagFailure signalWithTag: (aMooseModel findTagNamed: self mooseName) ]
		on: NotFound
		do: [ "This is the regular case; no conflict in the model"
			aMooseModel addTaggingEntityFirst: self.
			self privateSetMooseModel: aMooseModel ]
]

{ #category : #private }
FamixTag >> mooseModelWithoutCheck: aMooseModel [
	^ super mooseModel: aMooseModel
]

{ #category : #printing }
FamixTag >> mooseName [
	"A tag should always have a model. Thus we can remove the check in the overriden method for performances."

	^ mooseName
		ifNil: [ | stream |
			stream := (String new: 64) writeStream.
			self mooseNameOn: stream.
			mooseName := stream contents asSymbol ]
]

{ #category : #printing }
FamixTag >> mooseNameOn: aStream [
	self parentTag
		ifNotNil: [ :tag | 
			tag mooseNameOn: aStream.
			aStream << self parentSeparator ].
	aStream nextPutAll: (self name ifNil: [ #unamed ])
]

{ #category : #accessing }
FamixTag >> name [
	<FMProperty: #name type: #String>
	<FMComment: 'Name of the tag'>
	^ name
]

{ #category : #accessing }
FamixTag >> name: aString [
	name := aString
]

{ #category : #printing }
FamixTag >> parentSeparator [
	^ $>
]

{ #category : #accessing }
FamixTag >> parentTag [
	<FMProperty: #parentTag type: #FamixTag opposite: #subTags>
	<FMComment: 'Parent of the tag'>
	<container>
	^ parentTag
]

{ #category : #accessing }
FamixTag >> parentTag: aParentTag [
	(aParentTag = self or: [ self isAncestorOf: aParentTag ]) ifTrue: [ FamixTagRecursiveFailure signal ].

	aParentTag ifNotNil: [ :tag | tag checkChildValidity: self ].

	parentTag := FMMultivalueLink
		on: self
		update: #subTags
		from: self parentTag
		to: aParentTag.

	self resetMooseName
]

{ #category : #actions }
FamixTag >> promoteAsRoot [
	[ 
	"We check if the promotion would not create a conflict in the model"
	FamixAlreadyExistTagFailure signalWithTag: (self mooseModel findTagNamed: self name) ]
		on: NotFound
		do: [ parentTag := nil ]
]

{ #category : #removing }
FamixTag >> remove [
	self mooseModel
		ifNotNil: [ :model | 
			self deleteAssociationsInModel: model.
			self removeFromModel ].
	self setParentTagAtNil.
	self subTags do: #remove
]

{ #category : #removing }
FamixTag >> removeAndPromoteChildren [
	"This method will remove me and my children will be added to the children of my parent"

	self subTags copy do: [ :aSubTag | aSubTag changeParentTagTo: self parentTag ].
	self remove
]

{ #category : #removing }
FamixTag >> removeCategory: aTagCategory [
	self categories remove: aTagCategory
]

{ #category : #accessing }
FamixTag >> removeFromModel [
	^ self mooseModel
		ifNil: [ self ]
		ifNotNil: [ :model | model removeTaggingEntity: self ]
]

{ #category : #private }
FamixTag >> serializedColor [
	"Never use directly this instance variable; it is just to store the color in the model that only support string and not color type"

	<FMProperty: #serializedColor type: #String>
	<FMComment: 'Name of the method'>
	^ serializedColor
]

{ #category : #private }
FamixTag >> serializedColor: aString [
	"Never use directly this instance variable; it is just to store the color in the model that only support string and not color type"

	serializedColor := aString
]

{ #category : #accessing }
FamixTag >> setParentTagAtNil [
	parentTag := FMMultivalueLink
		on: self
		update: #subTags
		from: self parentTag
		to: nil.

	self resetMooseName
]

{ #category : #ston }
FamixTag >> stonContainSubObjects [
	^ false
]

{ #category : #ston }
FamixTag >> stonOn: stonWriter [
	stonWriter
		writeObject: self
		streamMap: [ :dictionary | 
			self class stonAllInstVarNames
				do: [ :each | 
					(self instVarNamed: each)
						ifNotNil: [ :value | 
							dictionary
								at: each asSymbol
								put:
									((value isCollection and: [ value isString not ])
										ifTrue: [ value asArray ]
										ifFalse: [ value ]) ] ] ]
]

{ #category : #accessing }
FamixTag >> subTagNamed: aString [
	^ [ self findSubTagNamed: aString ]
		on: NotFound
		do: [ self createSubTagNamedWithoutCheck: aString ]
]

{ #category : #accessing }
FamixTag >> subTags [
	<FMProperty: #subTags type: #FamixTag opposite: #parentTag>
	<multivalued>
	<FMComment: 'Sub tags of this composite tag.'>
	<derived>
	^ subTags
]

{ #category : #accessing }
FamixTag >> subTags: aCollection [
	subTags value: aCollection
]

{ #category : #actions }
FamixTag >> tagEntity: anEntity [
	FamixTagEntityAssociation newForEntity: anEntity tag: self
]

{ #category : #actions }
FamixTag >> tagWith: aTag [
	FamixTagOnTagFailure signal
]

{ #category : #actions }
FamixTag >> toggleVisibility [
	isHidden := isHidden not
]
