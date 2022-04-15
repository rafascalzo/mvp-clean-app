//
//  AlertView.swift
//  Presentation
//
//  Created by Rafael Scalzo on 15/04/22.
//

import Foundation

public protocol AlertView {
    func showMessage(viewModel: AlertViewModel)
}

public struct AlertViewModel : Equatable {
    
    public var title: String
    public var message: String
    
    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}
