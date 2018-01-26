//
//  VenueAPIClient.swift
//  VenueTips
//
//  Created by Masai Young on 1/18/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

class VenueSearchAPIClientWithAlamo {
    private init() {}
    static let manager = VenueSearchAPIClientWithAlamo()
    
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
    
    func searchEndpointWithNear(near: String, query: String) -> String {
        var endpoint = URLComponents(string: "https://api.foursquare.com/v2/venues/search")
        endpoint?.queryItems = [
            URLQueryItem(name: "near", value: near),
            URLQueryItem(name: "client_id", value: "IB3YSQFSP0OASTWQMKEV3M4WI31INRZQRFXVNFMS45QNZXDM"),
            URLQueryItem(name: "client_secret", value: "V5ZKW24F55SY0HROQYOXMILCHKXTBGPY0SCCAKEKRHLINPUY"),
            URLQueryItem(name: "v", value: "20180117"), //ENDPOINT USES CURRENT DAYS DATE?
            URLQueryItem(name: "query", value: query)
        ]
        let venueEndpoint = endpoint?.url?.absoluteString
        return venueEndpoint!
    }
    
    func searchEndpointWithUserLocation(_ coord: CLLocationCoordinate2D) -> String {
        var endpoint = URLComponents(string: "https://api.foursquare.com/v2/venues/search")
        endpoint?.queryItems = [
            URLQueryItem(name: "ll", value: "\(coord.latitude),\(coord.longitude)"),
            URLQueryItem(name: "client_id", value: "IB3YSQFSP0OASTWQMKEV3M4WI31INRZQRFXVNFMS45QNZXDM"),
            URLQueryItem(name: "client_secret", value: "V5ZKW24F55SY0HROQYOXMILCHKXTBGPY0SCCAKEKRHLINPUY"),
            URLQueryItem(name: "v", value: "20180117") //ENDPOINT USES CURRENT DAYS DATE?
        ]
        let venueEndpoint = endpoint?.url?.absoluteString
        return venueEndpoint!
    }
}
