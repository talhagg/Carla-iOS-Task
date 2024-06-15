//
//  RoverListContracts.swift
//  Case
//
//  Created by Talha Gölcügezli on 14.06.2024.
//

import Foundation

protocol RoversListViewModelProtocol : class {
    var delegate : RoversListViewModelDelegate? { get set }
    func load()
    func selectedRovers(_ rovers: RoversPresentation)
}

enum RoversListViewModelOutput {
    case isLoading(Bool)
    case showRoversList([RoversPresentation])
}

enum RoversListViewRoute {
    case detail(RoverDetailViewModelProtocol)
}

protocol RoversListViewModelDelegate : class {
    func handleViewOutput(_ output: RoversListViewModelOutput)
    func navigate(to route: RoversListViewRoute)
}
