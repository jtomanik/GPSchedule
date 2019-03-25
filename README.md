# GPSchedule
This app is a simple app that provides a Doctor with appointments list, that is using OpenMRS as a backend.

## Architecture decisions

### Context
With this app, I wanted to validate some of my architectural concepts and ideas.

Creating and maintaining large apps that should assist complex businesses processes comes with a unique set of challenges. One of those is maintaining codebase flexibility that would allow to easily add, change or extend features.

### Decision
I believe that a lot of those problems come from the tight coupling of Business and Presentation problem domains. 
This idea comes from the realization that Bussiness domain abstractions: models, processes and states, for any non-trivial app, will be different from Presentation domain models, processes and states. Obviously, there is also a third domain: Platform Domain that should be as loosely coupled with Presentation domain as possible.
However having separate states in Bussiness and Presentation domains can produce a completely new set of challenges, 
therefore this code should provide some insights about the feasibility of this approach.

#### Problem Domains
From the point of view of the software architecture we can define three distinct domains:

1. Business Domain.
It should be the most abstract one and should mimic business processes and actions that are carried by employees. Understanding and documenting this domain is very often a job of a Bussiness Analyst or a Project Owner.
In the context of this particular example, we have a notion of a Doctor who has a list of appointments with Patients.

2. Presentation Domain.
This domain provides an abstraction for processes of interacting and interpreting Business states and processes. Understanding and documenting this domain is very often a job of UX / Interaction designer.
It is concerned with the question: "How we should present current business state and business processes so the employees can perform their duties"
In the context of this particular example, Presentation Domain deals with questions like: 
"What information a Doctor should see on his upcoming appointments list" 
and
"What information Doctor needs before the appointment"
In non-digital practice, this may be something as simple as a Schedule book and patient's file.

3. Platform Domain. 
This domain deals with presenting current Presentation state on a final device/medium. Main person responsible for this domain is a UI designer.

#### Selected approach
When coming up with the architecture that could support having separate states in Bussiness and Presentation layers I wanted to come up with something based on the Unidirectional dataflows, Redux and concepts shown in the following repos:

[RxFeedback.swift](https://github.com/NoTests/RxFeedback.swift)
[ReactorKit](https://github.com/ReactorKit/ReactorKit)

Yet I wanted to fit them into MVVM type implementation as that could be better understood by people not familiar with Redux. Therefore we have

##### View. 
Views belong to the Platform domain. Those abstract Views are implemented using UIViewController and subclasses. Here is a short characteristic of a View:
- View holds strongly the ViewModel
- A view contains all the layout logic
- A view contains all the necessary subviews
- View dispatches user actions to the VM 
- View's appearance changes only in response to the changes in the VM's ViewState

##### ViewModel
View Models are implementations of an abstract View Reactor. They belong to the Presentation domain and their main duty is to react to the User Actions dispatched by the view and maintain current presentation state. Also, they are used to interact with Models and interpret their current state. 
Here is a short characteristic of a ViewModel:
- ViewModel has no knowledge of the View
- A ViewModel holds and transforms a ViewState
- A ViewModel responds to the UserActions dispatched to it
- A ViewModel responds to the changes in the state of a Model it has a reference to 
- ViewModel has all its dependencies injected
- ViewModel has no dependencies to UIKit
- ViewModel can be easily tested

##### Model
The Model is an abstract concept, and its main duty is to Store a State of a business process they represent. Models are implemented using UseCases. Use Cases have no knowledge of anything other than their State and events, rules and models associated with that state.
Here is a short characteristic of a UseCase:
- UseCases has no knowledge of anything but Business domain States and Events
- UseCases holds and transforms a specific DomainState
- UseCases responds to the Events dispatched to it
- UseCases can dispatch events to other UseCases
- UseCases has all its dependencies injected
- UseCases has no dependencies to UIKit
- UseCases can be easily tested

Overview of the architectural abstractions is available in the `AppArchitecture.swift` file has type and protocol definitions. Those abstractions are implemented by the generic types available in the `GenericArchitectureImplementation.swift` file. Lastly files `GenericUseCaseTests.swift` and `GenericViewModelTests.swift` further explain the behaviour of the main architectural building blocks used in this app.

### Consequences
As expected state synchronisation proved to be the main challenge, however using reactive bindings together with the functional style of the implementation allowed to manage this problem, in my opinion, quite nicely.

Having separate states increases the complexity and may be an overkill for such a simple app. Nonetheless, I think that implementing this app gave me a sense how empowering this concept can be when used in the situations where we have to deal with complex user interaction flows, complex business processes or even both within a single app. 

## Setup
This project has been tested with Xcode 10.1 on a MacOS 10.13.6

Tools needed to build and run this project

### Cocoapods
Using:
```
$ pod --version
1.6.1
```
Install: `$ sudo gem install cocoapods`

After checking out this repo run `pod install` in the main folder to install all dependencies.
Then please run `pod update Sourcery` if you don't have it already on your machine.

Note: In case of any problems with the Sourcery please refer to it's [Github repo](https://github.com/krzysztofzablocki/Sourcery)

## The backend
This project is using an [OpenMRS](https://openmrs.org/) as a backend.

OpenMRS is a patient-based medical record system focusing on giving providers a free customizable electronic medical record system (EMR).

To provide a meaningful set of data and API for this app an OpenMRS instance was set up on the Google Cloud and the swagger file describing this API was generated. 

This backend was chosen mainly due to the available documentation:
[REST Web Services API For Clients](https://wiki.openmrs.org/display/docs/REST+Web+Services+API+For+Clients#RESTWebServicesAPIForClients-Subresources)
[REST Web Service Resources in OpenMRS 1.9](https://wiki.openmrs.org/display/docs/REST+Web+Service+Resources+in+OpenMRS+1.9#RESTWebServiceResourcesinOpenMRS1.9-Order)
[User Stories](https://wiki.openmrs.org/display/projects/Appointment+Module?preview=/37290157/37617670/User%20Stories%20v3.pdf)
[Data Model](https://wiki.openmrs.org/display/docs/Data+Model)

In order to use this app, you need to have an account on the backend

## Generating the API client code

This project is using an API client generated by the `swagger-codegen` tool based on the swagger file.

### Installing  SwagGen
Installing SwagGen is only necessary when you need to generate an API client. it is **not** needed to run the code in this repo.

To install the tool go to SwagGen use Homebrew and run `brew install swagger-codegen` in your terminal.
```
$ swagger-codegen version
3.0.5
```

Next go to the directory where `openmrs.rest.swagger.json` is and run the following command:
`swagger-codegen generate -i openmrs.rest.swagger.json -l swift3 -o Generated/ -c config.json`
To generate the api client. That later can be imported into the project using cocoapods:
`  pod 'OpenMRS', :path => './GPSchedule/ApiClient/Generated/OpenMRS.podspec'`

## Running the app
After running the app you will be asked to login into a backend to fetch you scheduled appointments.

## ToDo (If I only had more time)
- Implement more complex flows
- implement more Unit tests
- Implement UI / Snapshot test

