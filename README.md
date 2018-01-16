## Unit 5 Group Project 

## Links

Trello: https://trello.com/b/bHwSih0g/group-project

## Overview 

Use MapKit and CoreLocation to build out a Foursquare like app with the following spcecifications:
* User can search for a venue
* The app shows results those results with annotations on a map
* The user can toggle between a map view and a list view
* If the user denies access to location, search still works
* User can create a collection 
* User can add venues to a collection 

* Each group member is responsible for Github commits to this project 
* Use Github and ```branch-group-membername``` in development
* When your group is ready to commit to master merge your changes to the ```master``` branch 
* We will be observing your commits when grading so use best practices when writing commits 
* Use animations in you app (refer to the [Human Interface guidlines](https://developer.apple.com/ios/human-interface-guidelines/visual-design/animation/))  



## Groupwork

[Groups](https://docs.google.com/spreadsheets/d/1Yn8gLFB6hr33EoBptPgqBqvehTi8C12BKz22GfJ25_Q/edit?ts=5a59316f#gid=0)

This is our first group project.  There are three large things to be aware of for group projects:

1. Git
2. Trello
3. Group Roles

### Git

Unlike homework in the past where you forked a C4Q repo, then committed and pushed at the end, a group project must be more colloborative.

Each group member should have their own *branch* with their name.  The *master* branch should only contain a working build of the project.  Each group member will work on their separate branches, then push their work to the master branch when they have completed a feature.  But how do you know what to work on?

### Trello

Each group member should have an account on [Trello](https://trello.com/) and the group should have a well maintained list of who is working on what task.  Without this, two people might try to edit the same file and create merge conflicts.

[Example](https://trello.com/b/DnZvFigA/agile-board)


### Group Roles

The expectation is that everyone in a group is chiefly occupied with writing code.  In addition to that, the following roles are important for someone to have explicit ownership of:

|Role|Responsibilities|
|:-------------:|:------------:|
| Technical Lead | In charge of maintaining the health of master branch and ensure that master is always safe to pull from.  Makes final decisions on project architecture in conversation with other team members |
| Project Manager | Is responsible for the health of the Trello or board.  Organizes daily standups |
| UI/UX | Is responsible for the design and flow of the app |
| QA | Is responsible for identifying bugs on master and that the final product is bug free |


## Gifs

|User Allowing Access|User Denying Location Access|
|:-------------:|:------------:|
|<img src="https://github.com/C4Q/AC-iOS-Unit5GroupProject/blob/master/Images/request-location-access-allow.gif" width="358" height="626">|<img src="https://github.com/C4Q/AC-iOS-Unit5GroupProject/blob/master/Images/request-location-access-denied.gif" width="358" height="626">|  

<br><br>
<p align="center"><b>User can search for a venue and toggle between the default search map or a list</b></p>
<p align="center">
<img src="https://github.com/C4Q/AC-iOS-Unit5GroupProject/blob/master/Images/search-for-venue.gif" width="358" height="626">
</p>

<br><br>
<p align="center"><b>User can change search location</b></p>
<p align="center">
<img src="https://github.com/C4Q/AC-iOS-Unit5GroupProject/blob/master/Images/change-location.gif" width="358" height="626">
</p>

<br><br>
<p align="center"><b>User can create a collection</b></p>
<p align="center">
<img src="https://github.com/C4Q/AC-iOS-Unit5GroupProject/blob/master/Images/create-collection.gif" width="358" height="626">
</p>

<br><br>
<p align="center"><b>User can add a venue to a collection</b></p>
<p align="center">
<img src="https://github.com/C4Q/AC-iOS-Unit5GroupProject/blob/master/Images/add-to-collection.gif" width="358" height="626">
</p>

<br><br>
<p align="center"><b>User can create a tip about a venue</b></p>
<p align="center">
<img src="https://github.com/C4Q/AC-iOS-Unit5GroupProject/blob/master/Images/create-a-tip.gif" width="358" height="626">
</p>

<br><br>
<p align="center"><b>User can get directions to a venue</b></p>
<p align="center">
<img src="https://github.com/C4Q/AC-iOS-Unit5GroupProject/blob/master/Images/get-directions.gif" width="358" height="626">
</p>

**Github**
* Designate a team member to create a new Github Repo e.g "VenueTips" repo
* Create the following branches: ```prod``` ```qa``` and ```dev``` 
* ```prod``` - this is the production branch that we will be reviewing as your final project submission 
* ```dev-group-member-name``` - this is your personal branch. Use this branch while working on your feature set. After you're done meet with team members to code review and merge your changes to the ```qa``` branch 
* ```qa``` - this branch should be used for testing your app, QA (quality assurance) branch. After the team has reviewed and tested on the ```qa``` branch you group will then merge to the production branch ```prod```



**Apply for a Foursquare Developer Account and API Key:**  
https://developer.foursquare.com/docs/api/getting-started  

[Foursquare Endpoint Overview](https://developer.foursquare.com/docs/api/endpoints)  

**Venue Search Endpoint:**  
Request: 
```
GET https://api.foursquare.com/v2/venues/search
```

**Venue Photos Endpoint:**  
Request: 
```
GET https://api.foursquare.com/v2/venues/VENUE_ID/photos
```

## Rubric 

|Architecture | Point|
|:----|:---|
|Variable Naming and Readability|4 Points|
|App uses AutoLayout correctly for all iPhones in portrait|4 Points|
|Proper Object Oriented Priciples are applied|4 Points|
|App uses MVC Design Patterns|4 Points|
|Proper use of Access Modifiers|4 Points|
|Proper use of Activity Indicators where applicable|4 Points|
|Keyboard Handling|4 Points|


|App Specific | Point|
|:----|:---|
|App shows coffee shops by Search in the case of location denial access|4 Points|
|Clicking on directions should open Apple Maps|4 Points|
|User should be able to create a tip about a venue|4 Points|
|User should be able to save a venue|8 Points|


|Group Specific | Point|
|:----|:---|
|Group Presentation|10 Points|
|README|4 Points|
|Gif|4 Points|


|Github | Point|
|:----|:---|
|Each Group member created their own branch in this project|2 Points|
|Commits from Group members|4 Points|
|All branches were merged to ```master```|2 Points|


|Cocoapods | Point|
|:----|:---|
|Use of SnapKit for ProgrammableUI layouts|4 Points|
|Use of Alamofire for Networking|4 Points|


|Error Handling and Network Handling | Point|
|:----|:---|
|Loss of Network Handling|4 Points|
|Proper error handling and notification to user|4 Points|
|Use empty states in app|4 Points|
|Proper handling of denial of location services request from user|4 Points|


|Gestures and Animations | Point|
|:----|:---|
|Gestures are used as needed where uses expect such behavior|2 Points|
|Animations are included while using best practices|4 Points|

Total Points: 106 points 

|Bonus Features | Point|
|:----|:---|
|Update a Venue|2 Points|
|Update a Collection|2 Points|
|Delete venue from a collection|2 Points|
|Delete Collection|2 Points|



