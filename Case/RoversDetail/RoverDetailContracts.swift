//
//  RoverDetailContracts.swift
//  Case
//
//  Created by Talha Gölcügezli on 14.06.2024.
//

import Foundation

protocol RoverDetailViewModelProtocol {
    var delegate : RoverDetailViewModelDelegate? { get set }
    func load()
}

enum RoverDetailViewModelOutput {
    case isLoading(Bool)
    case updateTitle(String)
    case showRoverDetailList([LatestPhotosPresentation])
}

protocol RoverDetailViewModelDelegate : class {
    func handleViewOutput(_ output: RoverDetailViewModelOutput)
}
