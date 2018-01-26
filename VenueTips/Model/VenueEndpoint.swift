//
//  VenueEndpoint.swift
//  VenueTips
//
//  Created by Masai Young on 1/25/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import Foundation
import CoreLocation

struct VenueEndpoint {
    let query, locationName: String?
    let userLocation: CLLocationCoordinate2D?
    let currentDate: String?
}
