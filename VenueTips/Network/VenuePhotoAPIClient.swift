//
//  VenuePhotoAPIClient.swift
//  VenueTips
//
//  Created by Masai Young on 1/18/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import Foundation
import Alamofire

class VenuePhotoAPIClient {
    private init() {}
    static let manager = VenuePhotoAPIClient()
    
    func getVenuePhotos(from urlStr: String, completionHandler: @escaping (VenuePhotoResults) -> Void, errorHandler: @escaping (Error) -> Void) {
        
        Alamofire.request(urlStr).responseJSON { (response) in
            guard let data = response.data else { return }
            switch response.result {
            case .success:
                do {
                    let results = try JSONDecoder().decode(VenuePhotoResults.self, from: data)
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
    
    func photoEndpoint(venue: Venue) -> String {
        let venueID = venue.id
        var endpoint = URLComponents(string: "https://api.foursquare.com/v2/venues/\(venueID)/photos")
        endpoint?.queryItems = [
            URLQueryItem(name: "client_id", value: "IB3YSQFSP0OASTWQMKEV3M4WI31INRZQRFXVNFMS45QNZXDM"),
            URLQueryItem(name: "client_secret", value: "V5ZKW24F55SY0HROQYOXMILCHKXTBGPY0SCCAKEKRHLINPUY"),
            URLQueryItem(name: "v", value: "20180117") //ENDPOINT USES CURRENT DAYS DATE?
        ]
        let venueEndpoint = endpoint?.url?.absoluteString
        return venueEndpoint!
    }
}
