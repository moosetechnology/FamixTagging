"
I am a baseline to define the structure and dependencies of the FamixTagging project.


This project is meant to be integrated in Moose, but also depend on Famix. Currently Moose and Famix are in the same repository.
This creates a problem because of the dependencies

Moose -> Tagging -> Famix 
		-> Famix
		
Metacello will detect both famix as different and will fail. To avoid that we create a baseline without famix and one with famix.
"
Class {
	#name : #BaselineOfFamixTaggingWithoutFamix,
	#superclass : #BaselineOf,
	#category : #BaselineOfFamixTaggingWithoutFamix
}

{ #category : #baseline }
BaselineOfFamixTaggingWithoutFamix >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ "Dependencies"
			self materialColor: spec.

			"Packages"
			spec
				package: 'Famix-Tagging' with: [ spec requires: #('MaterialColors') ];
				package: 'Famix-Tagging-Code' with: [ spec requires: #('Famix-Tagging') ];
				package: 'Famix-Tagging-Tests-Generator';
				package: 'Famix-Tagging-Tests-Entities';
				package: 'Famix-Tagging-Tests' with: [ spec requires: #('Famix-Tagging' 'Famix-Tagging-Code' 'Famix-Tagging-Tests-Entities') ].

			"Groups"
			spec
				group: 'TaggingMinimal' with: #('Famix-Tagging');
				group: 'Tagging' with: #('TaggingMinimal' 'Famix-Tagging-Code');
				group: 'TaggingTests' with: #('Famix-Tagging-Tests') ]
]

{ #category : #dependencies }
BaselineOfFamixTaggingWithoutFamix >> materialColor: spec [
	spec
		baseline: 'MaterialColors'
		with: [ spec
				loads: 'Core';
				repository: 'github://DuneSt/MaterialColors:v2.x.x/src' ]
]

{ #category : #accessing }
BaselineOfFamixTaggingWithoutFamix >> projectClass [
	^ MetacelloCypressBaselineProject
]
