# Berlin Clock
A Berlin Clock app for iOS, written with UIKit using Swift 5, and MVVM architecture. A TDD Aproach is used in the development.

## Installation
Open <i>Berlin Clock.xcodeproj</i> in XCode 12.

## Project description
MVVM Architectural pattern was chosen in order to benefit in the future implementations on a decoupled code, with separation of concerns.
MVVM Aproach was handled through binding between ViewModel and View, using the custom helper class <i> Dynamic.swift </i> 
 No Massive View Controller issues should appear during development
The view controller lifecycle is completly separated from the game's business logic, so unit tests can be written properly as the view model has no dependencies to the View Controller.

## Main classes

### BerlinClockViewModel

Contains the business logic for the app, and it's coupled with BerlinClockService which was designed as a service in the code. 
It mainly processes animations and ui actions and uses BerlinClockService to process the rules for the clock.
Unit tests are currently covering most basic scenarios, and can be improved with a real life test of the ticking clock.

### BerlinClockService

A service that provides the berlin clock rules and processes them. It's not computing the normal time format. The normal time is computed in the ViewModel.
Unit tests are covering the main scenarios for all the lamps, with individual tests, but it also contains an integration test that checks the entire clock functionality
