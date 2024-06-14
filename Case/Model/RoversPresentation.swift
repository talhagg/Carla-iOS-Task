//
//  RoversPresentation.swift
//  Case
//
//  Created by Talha Gölcügezli on 14.06.2024.
//

import Foundation
import CaseService

public struct RoversPresentation: Decodable {
    let name: String
    let landing_date: String
    let launch_date: String
    let status: String
}

extension RoversPresentation {
    init(rovers: Rovers) {
        self.init(name: rovers.name, landing_date: rovers.landing_date, launch_date: rovers.launch_date, status: rovers.status)
    }
}
