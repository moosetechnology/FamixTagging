"
I am a baseline to define the structure and dependencies of the FamixTagging project.
"
Class {
	#name : #BaselineOfFamixTagging,
	#superclass : #BaselineOf,
	#category : #BaselineOfFamixTagging
}

{ #category : #baseline }
BaselineOfFamixTagging >> baseline: spec [

	<baseline>
	spec for: #common do: [ "Dependencies"
		self materialColor: spec.

		"Packages"
		spec
			package: 'Famix-Tagging'
			with: [ spec requires: #( 'MaterialColors' ) ];
			package: 'Famix-Tagging-Code'
			with: [ spec requires: #( 'Famix-Tagging' ) ];
			package: 'Famix-Tagging-Tests-Generator';
			package: 'Famix-Tagging-Tests-Entities';
			package: 'Famix-Tagging-Tests' with: [ 
				spec requires:
						#( 'Famix-Tagging' 'Famix-Tagging-Code' 'Famix-Tagging-Tests-Entities' ) ].

		"If Famix is not already present"
		spec for: #NeedsFamix do: [ 
			self famix: spec.
			spec
				package: 'Famix-Tagging' with: [ spec requires: #( 'Famix' ) ];
				package: 'Famix-Tagging-Code'
				with: [ spec requires: #( 'FamixTraits' ) ];
				package: 'Famix-Tagging-Tests-Generator'
				with: [ spec requires: #( 'FamixGenerator' ) ];
				package: 'Famix-Tagging-Tests-Entities'
				with: [ spec requires: #( 'FamixTraits' ) ];
				package: 'Famix-Tagging-Tests'
				with: [ spec requires: #( 'FamixTestModels' ) ] ].

		"Groups"
		spec
			group: 'TaggingMinimal' with: #( 'Famix-Tagging' );
			group: 'Tagging' with: #( 'TaggingMinimal' 'Famix-Tagging-Code' );
			group: 'TaggingTests' with: #( 'Famix-Tagging-Tests' ) ]
]

{ #category : #accessing }
BaselineOfFamixTagging >> customProjectAttributes [

	^ RPackageOrganizer default packages
		  detect: [ :package | package name = 'BaselineOfFamix' ]
		  ifFound: [ #(  ) ]
		  ifNone: [ #( #NeedsFamix ) ]
]

{ #category : #dependencies }
BaselineOfFamixTagging >> famix: spec [
	spec
		baseline: 'Famix'
			with: [ spec
				loads: 'Minimal';
				repository: 'github://moosetechnology/Famix:v1.x.x/src' ];
		project: 'FamixTraits' copyFrom: 'Famix' with: [ spec loads: 'BasicTraits' ];
		project: 'FamixGenerator' copyFrom: 'Famix' with: [ spec loads: 'Basic' ];
		project: 'FamixTestModels' copyFrom: 'Famix' with: [ spec loads: 'TestModels' ]
]

{ #category : #dependencies }
BaselineOfFamixTagging >> materialColor: spec [
	spec
		baseline: 'MaterialColors'
		with: [ spec
				loads: 'Core';
				repository: 'github://DuneSt/MaterialColors:v2.x.x/src' ]
]

{ #category : #accessing }
BaselineOfFamixTagging >> projectClass [
	^ MetacelloCypressBaselineProject
]
