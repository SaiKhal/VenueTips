//
//  VenueResults.swift
//  VenueTips
//
//  Created by Masai Young on 1/18/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import Foundation

struct VenueSearchResults: Codable {
    let meta: Meta
    let notifications: [Notification]?
    var response: Response
}

struct Meta: Codable {
    let code: Int
    let requestID: String?
    let errorType: String?
    let errorDetail: String?
    
    enum CodingKeys: String, CodingKey {
        case code, errorType, errorDetail
        case requestID = "requestId"
    }
}

struct Notification: Codable {
    let type: String
    let item: Item
}

struct Item: Codable {
    let unreadCount: Int
}

struct Response: Codable {
    var venues: [Venue]?
    let confident: Bool?
    let geocode: Geocode?
}

struct Geocode: Codable {
    let what, purpleWhere: String
    let feature: Feature
    
    enum CodingKeys: String, CodingKey {
        case what
        case purpleWhere = "where"
        case feature
    }
}

struct Feature: Codable {
    let cc, name, displayName, matchedName: String
    let highlightedName: String
    let woeType: Int
    let slug, id, longID: String
    let geometry: Geometry
    
    enum CodingKeys: String, CodingKey {
        case cc, name, displayName, matchedName, highlightedName, woeType, slug, id
        case longID = "longId"
        case geometry
    }
}

struct Geometry: Codable {
    let center: Ne
    let bounds: Bounds
}

struct Bounds: Codable {
    let ne, sw: Ne
}

struct Ne: Codable {
    let lat, lng: Double
}

struct Venue: Codable {
    let id, name: String
    let contact: Contact
    let location: Location
    let categories: [Category]
    let verified: Bool
    let stats: Stats
    let allowMenuURLEdit: Bool?
    let beenHere: BeenHere
    let specials: Specials
    let hereNow: HereNow
    let referralID: String
    let venueChains: [VenueChain]
    let hasPerk: Bool
    let venueRatingBlacklisted: Bool?
    let storeID, url: String?
    let menu: Menu?
    let hasMenu: Bool?
    var photoURL: String?
    var tip: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, contact, location, categories, verified, stats
        case allowMenuURLEdit = "allowMenuUrlEdit"
        case beenHere, specials, hereNow
        case referralID = "referralId"
        case venueChains, hasPerk, venueRatingBlacklisted
        case storeID = "storeId"
        case url, menu, hasMenu, photoURL, tip
    }
}

struct BeenHere: Codable {
    let lastCheckinExpiredAt: Int
}

struct Category: Codable {
    let id, name, pluralName, shortName: String
    let icon: Icon
    let primary: Bool
}

struct Icon: Codable {
    let purplePrefix, suffix: String
    
    enum CodingKeys: String, CodingKey {
        case purplePrefix = "prefix"
        case suffix
    }
}

struct Contact: Codable {
    let phone, formattedPhone, twitter, instagram: String?
    let facebook, facebookName: String?
}

struct HereNow: Codable {
    let count: Int
    let summary: String
    let groups: [Group]
}

struct Group: Codable {
    let type, name: String
    let count: Int
}

struct Location: Codable {
    let lat, lng: Double
    let labeledLatLngs: [LabeledLatLng]?
    let cc, city, state, country: String?
    let formattedAddress: [String]
    let postalCode, address, crossStreet, neighborhood: String?
}

struct LabeledLatLng: Codable {
    let label: String
    let lat, lng: Double
}

struct Menu: Codable {
    let type, label, anchor, url: String
    let mobileURL: String
    let externalURL: String?
    
    enum CodingKeys: String, CodingKey {
        case type, label, anchor, url
        case mobileURL = "mobileUrl"
        case externalURL = "externalUrl"
    }
}

struct Specials: Codable {
    let count: Int
}

struct Stats: Codable {
    let checkinsCount, usersCount, tipCount: Int
}

struct VenueChain: Codable {
    let id: String
}
