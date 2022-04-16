//
//  AlertViewSpy.swift
//  PresentationTests
//
//  Created by Rafael Scalzo on 16/04/22.
//

import Foundation
import Presentation

class AlertViewSpy: AlertView {
    
    var emit: ((AlertViewModel) -> Void)?
    
    func observe(completion: @escaping (AlertViewModel) -> Void) {
        self.emit = completion
    }
    
    func showMessage(viewModel: AlertViewModel) {
        emit?(viewModel)
    }
}
