//
//  Venues.swift
//  VenueTips
//
//  Created by Masai Young on 1/19/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import Foundation

class Venues {
    private init() {}
    static let shared = Venues()
    
    private var venues = [Venue]()
    
    public func get() -> [Venue] {
        return venues
    }
    
    public func set(_ searchResults: VenueSearchResults) {
        self.venues = searchResults.response.venues
    }
}
