//
//  Rovers.swift
//  CaseService
//
//  Created by Talha Gölcügezli on 14.06.2024.
//

import Foundation


public struct Rovers: Decodable {
    public let id: Int
    public let name: String
    public let landing_date: String
    public let launch_date: String
    public let status: String
    public let max_sol: Int
    public let max_date: String
    public let total_photos: Int
    public let cameras: [Cameras]
}
