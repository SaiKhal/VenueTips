//
//  NetworkHelper.swift
//  VenueTips
//
//  Created by C4Q on 1/16/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import Foundation
class NetworkHelper {
    private init () {}
    static let manager = NetworkHelper()
    private let session = URLSession(configuration: .default)
    
    func performDataTask(with urlRequest: URLRequest, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        session.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async{
                if let error = error as? URLError {
                    print(error)
                    switch error {
                    case URLError.notConnectedToInternet:
                        errorHandler(AppError.noInternet)
                    default:
                        errorHandler(AppError.other(rawError: error))
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    if response.statusCode != 200 {
                        print("Error: \(response.statusCode)")
                        errorHandler(AppError.badResponseCode(code: response.statusCode))
                    }
                }
                
                if let data = data {
                    completionHandler(data)
                }
            }
            }.resume()
    }
}
