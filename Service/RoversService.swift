//
//  RoversService.swift
//  CaseService
//
//  Created by Talha Gölcügezli on 14.06.2024.
//

import Foundation
import Alamofire

protocol RoversServiceProtocol {
    func fetchRovers(completion: @escaping (Result<RoversResponse, RoversServiceError>) -> Void)
    func selectedFetchRovers(roverName: String, completion: @escaping (Result<[Cameras], RoversServiceError>) -> Void)
}

final class RoversService: RoversServiceProtocol {
    private let baseURL = URLManager.shared.getURL(for: .baseURL)
    private let errorHandler: ErrorHandling
    
    init(errorHandler: ErrorHandling = ErrorHandler()) {
        self.errorHandler = errorHandler
    }
    
    func fetchRovers(completion: @escaping (Result<RoversResponse, RoversServiceError>) -> Void) {
        AF.request(baseURL ?? "").validate().responseDecodable(of: RoversResponse.self) { response in
            switch response.result {
            case .success(let roversResponse):
                completion(.success(roversResponse))
            case .failure(let error):
                self.errorHandler.handleError(error: error, completion: completion)
            }
        }
    }
    
    func selectedFetchRovers(roverName: String, completion: @escaping (Result<[Cameras], RoversServiceError>) -> Void) {
        let urlString = "\(baseURL)/rovers/\(roverName)/latest_photos"
        
        AF.request(urlString).validate().responseDecodable(of: [Cameras].self) { response in
            switch response.result {
            case .success(let latestPhotos):
                completion(.success(latestPhotos))
            case .failure(let error):
                self.errorHandler.handleError(error: error, completion: completion)
            }
        }
    }
}
