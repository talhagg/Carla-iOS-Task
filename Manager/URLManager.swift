//
//  URLManager.swift
//  CaseService
//
//  Created by Talha Gölcügezli on 14.06.2024.
//

import Foundation

public struct URLManager {
    static let baseURL = "https://mars-photos.herokuapp.com/api/v1/rovers"
    static let latetsBaseURL = "http://mars-photos.herokuapp.com/api/v1/rovers"
    
    static func roverLatestPhotosURL(for roverName: String) -> String {
        return "\(latetsBaseURL)/\(roverName)/latest_photos"
    }
}

