//
//  ImageDownloader.swift
//  VenueTips
//
//  Created by Masai Young on 1/18/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import Foundation
import UIKit

//class ImageAPIClient {
//    private init() {}
//    static let manager = ImageAPIClient()
//    
//    func loadImage(from urlStr: String,
//                   completionHandler: @escaping (UIImage) -> Void,
//                   errorHandler: @escaping (Error) -> Void) {
//        
//        guard let url = URL(string: urlStr) else {
//            errorHandler(AppError.invalidImage)
//            return
//        }
//        
//        //Check to see if you downloaded an image with the same url
////        if let savedImage = FileManagerHelper.manager.getImage(with: urlStr) {
////            completionHandler(savedImage)
////            print("Loaded Iamge from Phone")
//        } else {
//            //If there is no image saved, get it from the internet
//            let completion: (Data) -> Void = {(data: Data) in
//                guard let onlineImage = UIImage(data: data) else {
//                    return
//                }
//                completionHandler(onlineImage)
//                
//                //This saves the image to the phone
//                FileManagerHelper.manager.saveImage(with: urlStr, image: onlineImage)
//                print("Saved Image to Phone")
//                
//            }
//            NetworkHelper.manager.performDataTask(with: URLRequest(url: url),
//                                                  completionHandler: completion,
//                                                  errorHandler: errorHandler)
//        }
//    }
//}

struct ImageDownloader {
    private init() {}
    static let manager = ImageDownloader()
    func getImage(from urlStr: String, completionHandler: @escaping (UIImage) -> Void, errorHandler: (Error) -> Void) {
        // MARK: - Downloads images async
        if let albumURL = URL(string: urlStr) {
            // doing work on a background thread
            DispatchQueue.global().async {
                if let data = try? Data.init(contentsOf: albumURL) {
                    if let image = UIImage(data: data) {
                    // go back to main thread to update UI
                    DispatchQueue.main.async {
                        completionHandler(image)
                        }
                    }
                }
            }
        }
    }
}


