//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Rafael Scalzo on 15/04/22.
//

import Foundation

public final class SignUpPresenter {
    
    private let alertView: AlertView
    
    public init(alertView: AlertView) {
        self.alertView = alertView
    }
    
    public func signUp(viewModel: SignUpViewModel) {
        do {
            try validate(viewModel: viewModel)
        } catch let error as ValidationError {
            alertView.showMessage(viewModel: AlertViewModel(title: "Validation failed", message: error.message))
        } catch {
            return
        }
    }
    
    private func validate(viewModel: SignUpViewModel) throws {
        if viewModel.name == nil || viewModel.name?.isEmpty ?? true {
            throw ValidationError.required_name
        } else if viewModel.email == nil || viewModel.email?.isEmpty ?? true {
            throw ValidationError.required_email
        } else if viewModel.password == nil || viewModel.password?.isEmpty ?? true {
            throw ValidationError.required_password
        } else if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation?.isEmpty ?? true {
            throw ValidationError.required_password_confirmation
        } else if viewModel.password != viewModel.passwordConfirmation {
            throw ValidationError.password_not_match
        }
    }
}

public struct SignUpViewModel {
    
    public var name: String?
    public var email: String?
    public var password: String?
    public var passwordConfirmation: String?
    
    public init(name: String? = nil, email: String? = nil, password: String? = nil, passwordConfirmation: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}

enum ValidationError: LocalizedError {
    
    case required_name, required_email, required_password, required_password_confirmation, password_not_match
    
    var message: String {
        switch self {
        case .required_name: return "Name is required"
        case .required_email: return "Email is required"
        case .required_password: return "Password is required"
        case .required_password_confirmation: return "Password confirmation is required"
        case .password_not_match: return "Password not match"
        }
    }
}
