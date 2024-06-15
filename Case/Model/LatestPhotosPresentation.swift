//
//  LatestPhotosPresentation.swift
//  Case
//
//  Created by Talha Gölcügezli on 15.06.2024.
//

import Foundation
import CaseService

public struct LatestPhotosPresentation: Decodable {
    let id: Int
    let img_src: String
    let earth_date: String
    let camera: Camera
    let rovers: Rovers
}

extension LatestPhotosPresentation {
    init(photos: LatestPhotos) {
        self.init(id: photos.id, img_src: photos.img_src, earth_date: photos.earth_date, camera: photos.camera, rovers: photos.rover)
    }
}
