//
//  ImageDownloader.swift
//  VenueTips
//
//  Created by Masai Young on 1/18/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import Foundation

struct ImageDownloader {
    private init() {}
    static let manager = ImageDownloader()
    func getImage(from urlStr: String, completionHandler: @escaping (Data) -> Void, errorHandler: (Error) -> Void) {
        // MARK: - Downloads images async
        if let albumURL = URL(string: urlStr) {
            // doing work on a background thread
            DispatchQueue.global().async {
                if let data = try? Data.init(contentsOf: albumURL) {
                    // go back to main thread to update UI
                    DispatchQueue.main.async {
                        completionHandler(data)
                    }
                }
            }
        }
    }
}


