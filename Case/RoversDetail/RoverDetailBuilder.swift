//
//  RoverDetailBuilder.swift
//  Case
//
//  Created by Talha Gölcügezli on 14.06.2024.
//

import Foundation
import CaseService

public final class RoverDetailBuilder {
    static func make(roverName: String?) -> RoverDetailVC {
        let view = RoverDetailVC()
        let errorHandler = ErrorHandler()
        let service = RoversService(errorHandler: errorHandler)
        let viewModel = RoverDetailViewModel(service: service)
        viewModel.roverName = roverName
        view.viewModel = viewModel
        
        return view
    }
}
