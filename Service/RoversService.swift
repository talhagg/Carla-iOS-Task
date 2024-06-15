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
    func selectedFetchRovers(roverName: String, completion: @escaping (Result<[Cameras], RoversServiceError>) -> Void)
}

public final class RoversService: RoversServiceProtocol {
    private let baseURL = "https://mars-photos.herokuapp.com/api/v1/rovers"//URLManager.shared.getURL(for: .baseURL)
    private let errorHandler: ErrorHandling
    
    public init(errorHandler: ErrorHandling = ErrorHandler()) {
        self.errorHandler = errorHandler
    }
    
    public func fetchRovers(completion: @escaping (Result<RoversResponse, RoversServiceError>) -> Void) {
        AF.request(baseURL ?? "").validate().responseData { response in
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
    
    public func selectedFetchRovers(roverName: String, completion: @escaping (Result<[Cameras], RoversServiceError>) -> Void) {
        let urlString = "\(baseURL)/rovers/\(roverName)/latest_photos"
        
        AF.request(urlString).validate().responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode([Cameras].self, from: data)
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
