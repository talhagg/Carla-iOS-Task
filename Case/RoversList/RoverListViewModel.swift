//
//  RoverListViewModel.swift
//  Case
//
//  Created by Talha Gölcügezli on 14.06.2024.
//

import Foundation
import CaseService

final class RoverListViewModel: RoversListViewModelProtocol {
    var delegate: RoversListViewModelDelegate?
    
    private let service: RoversServiceProtocol!
    
    init(service: RoversServiceProtocol) {
        self.service = service
    }
    
    func load() {
        notify(.isLoading(true))
        self.service.fetchRovers { [weak self] result in
            self?.notify(.isLoading(false))
            switch result {
            case .success(let success):
                let roversData = success.roversResult
                let data = roversData.map(RoversPresentation.init)
                self?.notify(.showCryptoList(data))
                print("data: \(data)")
            case .failure(let failure):
                //todo
                print("error: \(failure)")
            }
        }
    }
    
    func selectedCrypto(_ rovers: RoversPresentation) {
        //todo
    }
    
    private func notify(_ output: RoversListViewModelOutput) {
        delegate?.handleViewOutput(output)
    }
    
}
