//
//  LocationHelper.swift
//  
//
//  Created by Masai Young on 1/25/18.
//

import UIKit
import Foundation
import CoreLocation
// CLLocation has points: lat and long

class LocationHelper: NSObject {
    
    //singleton manager
    //BP: Apple highly recommends having one instance of the location manager
    private override init(){
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    static let manager = LocationHelper()
    private var locationManager: CLLocationManager!
}

//MARK: - Helper Functions
extension LocationHelper {
    //Checking to see if user has or has not authorized location services
    public func checkForLocationServices() -> CLAuthorizationStatus {
        var status: CLAuthorizationStatus!
        
        //check if location services are enabled
        if CLLocationManager.locationServicesEnabled(){
            switch CLLocationManager.authorizationStatus(){
            case .notDetermined: //initial state on first launch
                print("not detirmined")
                locationManager.requestWhenInUseAuthorization()
            case .denied: //user could potentially deny access
                print("denied")
            case .authorizedAlways:
                print("authorized always")
            case .authorizedWhenInUse:
                print("authorizedWhenInUse")
            default:
                break
            }
        }
        else {
            //TODO: - update UI accordingly
            status = CLLocationManager.authorizationStatus()
        }
        status = CLLocationManager.authorizationStatus()
        return status
    }
}

//MARK: - CLLoation Manager Delegate
extension LocationHelper: CLLocationManagerDelegate {
    //called every time user updates location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("did update with CLLocation \(locations)")
        
        guard let location = locations.last else {print("no location data");return}
        
        //Update User Preferences: sets users last location as the location when you open the app back up
        UserDefaultsHelper.manager.setLatitude(latitude: location.coordinate.latitude)
        UserDefaultsHelper.manager.setLongitude(longitude: location.coordinate.longitude)
        //locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Did fail with \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization: \(status)") //ex) .denied, .notDetermined
    }
}


