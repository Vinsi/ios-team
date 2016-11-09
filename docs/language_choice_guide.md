# Language choice

A guide for determining what language to choose for bug fixes, improvements or new features.
Generally, any new class has to be written in Swift, unless it brings many interoperability problems to solve.

## Bug fixes and improvements

* Bug fixes and improvements are written in the same language of where bugs exist or where improvements need to be done. 
* If there is a new class to be written, it has to be written in Swift unless it causes many problems specially in Unit Testing the Swift class from Objective-C.

## New features

* New features are implemented in Swift. 
* If a feature is totally dependent on Objective-C classes and must be written inside them, and writing it in Swift will bring many problems to solve especially in Unit Testing Swift from Objective-C, then it can be written in Objective-C.
