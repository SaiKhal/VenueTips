//
//  VenuePhotos.swift
//  VenueTips
//
//  Created by Masai Young on 1/18/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import Foundation

struct VenuePhotoResults: Codable {
    let meta: Meta
    let notifications: [Notification]
    let response: PhotoResponse
}


struct PhotoResponse: Codable {
    let photos: Photos
}

struct Photos: Codable {
    let count: Int
    let items: [PhotosItem]
    let dupesRemoved: Int
}

struct PhotosItem: Codable {
    let id: String
    let createdAt: Int
    let source: Source
    let purplePrefix, suffix: String
    let width, height: Int
    let user: With
    let checkin: Checkin?
    let visibility: String
    let tip: Tip?
    
    enum CodingKeys: String, CodingKey {
        case id, createdAt, source
        case purplePrefix = "prefix"
        case suffix, width, height, user, checkin, visibility, tip
    }
}

struct Checkin: Codable {
    let id: String
    let createdAt: Int
    let type: String
    let timeZoneOffset: Int
    let with: [With]?
}

struct With: Codable {
    let id, firstName: String
    let lastName: String?
    let gender: String
    let photo: Photo
}

struct Photo: Codable {
    let purplePrefix, suffix: String
    
    enum CodingKeys: String, CodingKey {
        case purplePrefix = "prefix"
        case suffix
    }
}

struct Source: Codable {
    let name, url: String
}

struct Tip: Codable {
    let id: String
    let createdAt: Int
    let text, type, canonicalURL: String
    let likes: Likes
    let like, logView: Bool
    let agreeCount, disagreeCount: Int
    let todo: Todo
    
    enum CodingKeys: String, CodingKey {
        case id, createdAt, text, type
        case canonicalURL = "canonicalUrl"
        case likes, like, logView, agreeCount, disagreeCount, todo
    }
}

struct Likes: Codable {
    let count: Int
//    let groups: [Group]
    let summary: String?
}

struct Todo: Codable {
    let count: Int
}
