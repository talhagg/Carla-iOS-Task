//
//  RoversResponse.swift
//  CaseService
//
//  Created by Talha Gölcügezli on 14.06.2024.
//

import Foundation

public final class RoversResponse: Decodable {
    
    private enum RoversContainer: String, CodingKey {
        case rovers
    }
    
    public let roversResult: [Rovers]
    
    public init(from decoder: Decoder) throws {
        let roversContainer = try decoder.container(keyedBy: RoversContainer.self)
        self.roversResult = try roversContainer.decode([Rovers].self, forKey: .rovers)
    }
}
