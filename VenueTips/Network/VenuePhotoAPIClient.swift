//
//  VenuePhotoAPIClient.swift
//  VenueTips
//
//  Created by Masai Young on 1/18/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import Foundation

struct VenuePhotoAPIClient {
    private init() {}
    static let manager = VenuePhotoAPIClient()
    
    func getVenuePhotos(from urlStr: String, completionHandler: @escaping (VenuePhotoResults) -> Void, errorHandler: (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        
//        if let cachedImage = ImageCache.manager.getImage(urlStr: urlStr) {
//            completionHandler(cachedImage)
//            return
//        }
        
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let photos = try JSONDecoder().decode(VenuePhotoResults.self, from: data)
                completionHandler(photos)
            }
            catch {
                print(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url),
                                              completionHandler: completion,
                                              errorHandler: {print($0)})
    }
    
    func photoEndpoint(venue: Venue) -> String {
        let venueID = venue.id
        var endpoint = URLComponents(string: "https://api.foursquare.com/v2/venues/\(venueID)/photos")
        endpoint?.queryItems = [
            URLQueryItem(name: "oauth_token", value: "BAKSUNZT0PTGTTLTWFGGXDGYLGKFBRCPZFU1EA4221TM1DIM"),
            URLQueryItem(name: "v", value: "20180117") //ENDPOINT USES CURRENT DAYS DATE?
        ]
        let venueEndpoint = endpoint?.url?.absoluteString
        return venueEndpoint!
    }
}
