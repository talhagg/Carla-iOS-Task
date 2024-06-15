//
//  RoverListViewModel.swift
//  Case
//
//  Created by Talha Gölcügezli on 14.06.2024.
//

import Foundation
import CaseService

final class RoverListViewModel: RoversListViewModelProtocol {
    
    weak var delegate: RoversListViewModelDelegate?
    
    private let service: RoversServiceProtocol!
    private var selectedRover: RoversPresentation?
    
    init(service: RoversServiceProtocol) {
        self.service = service
    }
    
    func load() {
        notify(.isLoading(true))
        DispatchQueue.main.async {
            self.service.fetchRovers { [weak self] result in
                self?.notify(.isLoading(false))
                switch result {
                case .success(let success):
                    let roversData = success.roversResult
                    let data = roversData.map(RoversPresentation.init)
                    self?.notify(.showRoversList(data))
                case .failure(let failure):
                    print("error: \(failure)")
                }
            }
        }
    }
    
    func selectedRovers(_ rovers: RoversPresentation) {
        selectedRover = rovers
        let viewModel = RoverDetailViewModel(service: service)
        delegate?.navigate(to: .detail(viewModel))
    }
    
    private func notify(_ output: RoversListViewModelOutput) {
        delegate?.handleViewOutput(output)
    }
    
    func getSelectedRoverName() -> String? {
        return selectedRover?.name
    }
    
}
