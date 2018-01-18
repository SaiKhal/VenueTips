//
//  VenueAPIClient.swift
//  VenueTips
//
//  Created by Masai Young on 1/18/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import Foundation

struct VenueSearchAPIClient {
    private init() {}
    static let manager = VenueSearchAPIClient()
    
    func getSearchResults(from urlStr: String, completionHandler: @escaping (VenueSearchResults) -> Void, errorHandler: (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        
        //        if let cachedImage = ImageCache.manager.getImage(urlStr: urlStr) {
        //            completionHandler(cachedImage)
        //            return
        //        }
        
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let results = try JSONDecoder().decode(VenueSearchResults.self, from: data)
                completionHandler(results)
            }
            catch {
                print(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url),
                                              completionHandler: completion,
                                              errorHandler: {print($0)})
    }
    
    func searchEndpointWithNear(near: String, query: String) -> String {
        var endpoint = URLComponents(string: "https://api.foursquare.com/v2/venues/search")
        endpoint?.queryItems = [
            URLQueryItem(name: "near", value: near),
            URLQueryItem(name: "oauth_token", value: "BAKSUNZT0PTGTTLTWFGGXDGYLGKFBRCPZFU1EA4221TM1DIM"),
            URLQueryItem(name: "v", value: "20180117"), //ENDPOINT USES CURRENT DAYS DATE?
            URLQueryItem(name: "query", value: query)
        ]
        let venueEndpoint = endpoint?.url?.absoluteString
        return venueEndpoint!
    }
}


