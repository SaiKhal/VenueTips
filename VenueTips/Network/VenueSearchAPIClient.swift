//
//  VenueAPIClient.swift
//  VenueTips
//
//  Created by Masai Young on 1/18/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import Foundation
import Alamofire

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

struct VenueSearchAPIClientWithAlamo {
    private init() {}
    static let manager = VenueSearchAPIClientWithAlamo()
    
    func getSearchResults(from urlStr: String, completionHandler: @escaping (VenueSearchResults) -> Void, errorHandler: (Error) -> Void) {
        
        Alamofire.request(urlStr).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let results = try JSONDecoder().decode(VenueSearchResults.self, from: data)
                    completionHandler(results)
                }
                catch {
                    print(error)
                }
            case let .failure(error):
                guard let error = error as? AFError else { print("Not AFError"); return }
                switch error {
                case .invalidURL(let url):
                    print("Invalid URL: \(url) - \(error.localizedDescription)")
                case .parameterEncodingFailed(let reason):
                    print("Parameter encoding failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                case .multipartEncodingFailed(let reason):
                    print("Multipart encoding failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                case .responseValidationFailed(let reason):
                    print("Response validation failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                    
                    switch reason {
                    case .dataFileNil, .dataFileReadFailed:
                        print("Downloaded file could not be read")
                    case .missingContentType(let acceptableContentTypes):
                        print("Content Type Missing: \(acceptableContentTypes)")
                    case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                        print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                    case .unacceptableStatusCode(let code):
                        print("Response status code was unacceptable: \(code)")
                    }
                case .responseSerializationFailed(let reason):
                    print("Response serialization failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                }
            }
        }
        
        
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








