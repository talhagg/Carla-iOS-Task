//
//  RoverDetailViewModel.swift
//  Case
//
//  Created by Talha Gölcügezli on 14.06.2024.
//

import Foundation
import CaseService

final class RoverDetailViewModel: RoverDetailViewModelProtocol {
    weak var delegate: (any RoverDetailViewModelDelegate)?
    
    private let service: RoversServiceProtocol!
    var roverName: String?
    
    
    init(service: RoversServiceProtocol) {
        self.service = service
    }
    
    func load() {
        notify(.isLoading(true))
        guard let roverNames = roverName else { return }
        notify(.updateTitle(roverNames))
        DispatchQueue.main.async {
            self.service.selectedFetchRovers(roverName: roverNames) { [weak self] result in
                self?.notify(.isLoading(false))
                switch result {
                case .success(let success):
                    let latestData = success.latestPhotoResult
                    let data = latestData.map(LatestPhotosPresentation.init)
                    self?.notify(.showRoverDetailList(data))
                case .failure(let failure):
                    print("latestphotos error: \(failure)")
                }
            }
        }
    }

    private func notify(_ output: RoverDetailViewModelOutput) {
        delegate?.handleViewOutput(output)
    }

    
}
