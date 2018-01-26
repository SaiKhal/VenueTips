//
//  PersistantManager.swift
//  VenueTips
//
//  Created by C4Q on 1/23/18.
//  Copyright © 2018 Masai Young. All rights reserved.


import Foundation
import UIKit
class PersistantManager {
    
    private init() {}
    static var manager = PersistantManager()
    let kPath = "myVenues.plist"
    let cPath = "collections.plist"
    var collectionNames = [String]() {
        didSet {
            saveCollections()
        }
    }
    
    private var venues = [String: [(Venue)]]() {
        didSet {
            saveVenues()
        }
    }
    
    func getDocumentDirectory() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[0]
    }
    func dataFilePath(of pathName: String) -> URL {
        return getDocumentDirectory().appendingPathComponent(pathName)
    }
    // add new name to collectionNames
    func addNewCollection(newName: String) {
        collectionNames.append(newName)
        venues[newName] = []
    }
    // get collections
    func getCollections() -> [String] {
        return collectionNames
    }
    // save collections
    func saveCollections() {
        let urlPath = dataFilePath(of: cPath)
        do {
            let data = try PropertyListEncoder().encode(collectionNames)
            try data.write(to: urlPath)
            
            print("===========collections==================\n")
            print(urlPath)
            print("=======================================")
        } catch {
            print("encoding collections error: \(error)")
        }
    }
    
    // load collections
    func loadCollections() {
        let urlPath = dataFilePath(of: cPath)
        do {
            let data = try Data(contentsOf: urlPath)
            collectionNames = try PropertyListDecoder().decode([String].self, from: data)
        } catch {
            print("Decoding collections error: \(error)")
        }
    }
    
    
    // load
    func load() {
        let urlPath = dataFilePath(of: kPath)
        do {
            let data = try Data(contentsOf: urlPath)
            venues = try PropertyListDecoder().decode([String: [Venue]].self, from: data)
        } catch {
            print("Decoding data error: \(error)")
        }
    }
    // save
    func saveVenues() {
        let urlPath = dataFilePath(of: kPath)
        do {
            let data = try PropertyListEncoder().encode(venues)
            try data.write(to: urlPath)
            
            print("=============================\n")
            print(urlPath)
            print("=============================")
        } catch {
            print("encoding data error: \(error)")
        }
    }
    // load image
    func getImage(venue: Venue) -> UIImage? {
        let imageUrl = dataFilePath(of: venue.id)
        do {
            let data =  try Data(contentsOf: imageUrl)
            let image = UIImage(data: data)
            return image
        } catch {
            print("loading image error: \(error)")
        }
        return nil
    }
    // get venues
    func getVenues() -> [String: [Venue]]{
        return venues
    }
    // add venues, save image to file
    func addVenue(newVenue: Venue, and newImage: UIImage, collectionName: String, tip: String?) {
        // check venue already saved or not
        let index = venues[collectionName]?.index(where: {newVenue.id == $0.id})
        if index != nil { return }
        
        var venueToAdd = newVenue
        venueToAdd.tip = tip
        self.venues[collectionName]!.append(venueToAdd)
        
        let imageUrl = dataFilePath(of: newVenue.id)
        if let imageData = UIImagePNGRepresentation(newImage) {
            do {
                try imageData.write(to: imageUrl)
            } catch {
                print("Saving image error: \(error)")
            }
        }
        
    }
}
