//
//  LatestPhotoResponse.swift
//  CaseService
//
//  Created by Talha Gölcügezli on 15.06.2024.
//

import Foundation

public final class LatestPhotoResponse: Decodable {
    
    private enum LatestPhotoContainer: String, CodingKey {
        case latest_photos
    }
    
    public let latestPhotoResult: [LatestPhotos]
    
    public init(from decoder: Decoder) throws {
        let roversContainer = try decoder.container(keyedBy: LatestPhotoContainer.self)
        self.latestPhotoResult = try roversContainer.decode([LatestPhotos].self, forKey: .latest_photos)
    }
}
