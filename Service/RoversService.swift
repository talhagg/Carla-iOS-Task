//
//  RoversService.swift
//  CaseService
//
//  Created by Talha Gölcügezli on 14.06.2024.
//

import Foundation
import Alamofire

public protocol RoversServiceProtocol {
    func fetchRovers(completion: @escaping (Result<RoversResponse, RoversServiceError>) -> Void)
    func selectedFetchRovers(roverName: String, completion: @escaping (Result<LatestPhotoResponse, RoversServiceError>) -> Void)
}

public final class RoversService: RoversServiceProtocol {
    private let errorHandler: ErrorHandling
    
    public init(errorHandler: ErrorHandling = ErrorHandler()) {
        self.errorHandler = errorHandler
    }
    
    public func fetchRovers(completion: @escaping (Result<RoversResponse, RoversServiceError>) -> Void) {
        AF.request(URLManager.baseURL).validate().responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(RoversResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    self.errorHandler.handleError(error: error, completion: completion)
                }
            case .failure(let error):
                self.errorHandler.handleError(error: error, completion: completion)
            }
        }
    }
    
    public func selectedFetchRovers(roverName: String, completion: @escaping (Result<LatestPhotoResponse, RoversServiceError>) -> Void) {
        let urlString = URLManager.roverLatestPhotosURL(for: roverName)
        
        AF.request(urlString).validate().responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(LatestPhotoResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    self.errorHandler.handleError(error: error, completion: completion)
                }
            case .failure(let error):
                self.errorHandler.handleError(error: error, completion: completion)
            }
        }
    }
}
