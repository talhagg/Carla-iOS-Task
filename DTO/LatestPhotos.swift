//
//  LatestPhotos.swift
//  CaseService
//
//  Created by Talha Gölcügezli on 15.06.2024.
//

import Foundation

public struct LatestPhotos: Decodable {
    public let id: Int
    public let sol: Int
    public let camera: Camera
    public let img_src: String
    public let earth_date: String
    public let rover: Rovers
}
