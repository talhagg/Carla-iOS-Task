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
    func selectedCrypto(_ rovers: RoversPresentation)
}

enum RoversListViewModelOutput {
    case updateTitle(String)
    case isLoading(Bool)
    case showCryptoList([RoversPresentation])
}

enum RoversListViewRoute {
    case detail(RoverDetailViewModelProtocol)
}

protocol RoversListViewModelDelegate : class {
    func handleViewOutput(_ output: RoversListViewModelOutput)
    func navigate(to route: RoversListViewRoute)
}
