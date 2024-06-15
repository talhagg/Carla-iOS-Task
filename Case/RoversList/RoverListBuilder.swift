//
//  RoverListBuilder.swift
//  Case
//
//  Created by Talha Gölcügezli on 14.06.2024.
//

import Foundation
import CaseService

public final class RoverListBuilder {
    
    static func make() -> RoverListVC {
        let view = RoverListVC()
        let errorHandler = ErrorHandler()
        let service = RoversService(errorHandler: errorHandler)
        let viewModel = RoverListViewModel(service: service)
        view.viewModel = viewModel
        
        return view
    }
}
