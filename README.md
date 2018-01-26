## VenueTips 

### Group Roles 

Project Manager | Tech Lead | UI/UX Designer | Quality Assurance
--- | --- | --- | ---
Iram | Masai | Nicole | XianXian


### Trello

Trello: https://trello.com/b/bHwSih0g/venuetips

## App Overview 

1. Use FourSquare API to access venues
    * User can search by location 
    * User can search by query e.g Coffee 
2. Integrate MapKit to show live updates on map based on search results 
    * Annotations update on map
    * Details about the venue on Annotations 
    * Directions to selected venue using apple maps
3. Use CoreLocation to track user's Location 
    * Authorization to allow location services 
4. Display detailed information about certain venues 
    * Images of venues
    * Directions to venue 
5. Custom Venue Collections
    * Users can create collections of certain venues
    * Users can add any venue to existing collections or make a new collection 
6. Leave tips for venues 
    * Users can create little messages and have them saved for that venue. 




## Design Patterns 

Some of the design patterns we decided to use to model our app. 

1. Dependency Injection. Certain views require properties in order to configure. In the code below, our view requires a Venue and Photo object in order to configure. 

```swift
 init(venue: Venue?, photo: UIImage?) {
        self.venue = venue
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not using coder!")
    }  
```
2. CocoaPods. We made use of various pods for different features. Here are some examples below 
    * KingFisher used to load and store images 
```swift 

        let completion: (VenuePhotoResults) -> Void = { [unowned self] (results) in
            guard let photo = results.response.photos.items.first else { return }
            let endpoint = "\(photo.purplePrefix)original\(photo.suffix)"
            let placeholderImage = UIImage(named: "placeholder-image")
            cell.imageView?.kf.indicatorType = .activity
            cell.imageView?.kf.setImage(with: URL(string: endpoint)!, placeholder: placeholderImage, completionHandler: { (_, _, _, _) in
                cell.setNeedsLayout()
            })
        }
```
    
   * SnapKit used to simplify UI constraints 
  ```swift 
  func setupTipLabel() {
        addSubview(tiplabel)
        tiplabel.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(directionButton.snp.bottom)
            make.width.equalTo(snp.width)
            make.height.equalTo(snp.height).multipliedBy(0.07)
            make.centerX.equalTo(snp.centerX)
        }
    }
```


   * Alamofire for network requests
   ```swift 
   func getSearchResults(from venueEndpoint: VenueEndpoint, completionHandler: @escaping (VenueSearchResults) -> Void, errorHandler: @escaping (Error) -> Void) {
        
        var endpoint = String()
        
        if let userLocation = venueEndpoint.userLocation, venueEndpoint.locationName == nil {
            endpoint = searchEndpointWithUserLocation(userLocation)
        } else {
            guard let locationName = venueEndpoint.locationName, let query = venueEndpoint.query else { return }
            endpoint = searchEndpointWithNear(near: locationName, query: query)
        }
        
        Alamofire.request(endpoint).responseJSON { (response) in
            guard let data = response.data else { return }
            switch response.result {
            case .success:
                do {
                    let results = try JSONDecoder().decode(VenueSearchResults.self, from: data)
                    completionHandler(results)
                }
                catch {
                    print(error)
                }
            case let .failure(error):
                errorHandler(error)
            }
            
        }
        
    }
 ```
    
    

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



