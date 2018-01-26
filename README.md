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





