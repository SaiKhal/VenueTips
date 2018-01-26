//
//  AppError.swift
//  VenueTips
//
//  Created by C4Q on 1/16/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import Foundation
enum AppError: Error {
    case badURL(url: String)
    case badImageURL(url: String)
    case badData
    case badResponseCode(code: Int)
    case cannotParseJSON(rawError: Error)
    case noInternet
    case other(rawError: Error)
    case invalidImage
}
