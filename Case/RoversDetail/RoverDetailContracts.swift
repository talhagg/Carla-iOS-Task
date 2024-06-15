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

protocol RoverDetailViewModelDelegate : class {
    func showDetail(_ presentation: String)
}
