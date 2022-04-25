//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Rafael Scalzo on 15/04/22.
//

import Foundation
import Domain

public final class SignUpPresenter {
    
    private let alertView: AlertView
    private let emailValidator: EmailValidator
    private let createAccount: CreateAccount
    private let loadingView: LoadingView
    
    public init(alertView: AlertView, emailValidator: EmailValidator, createAccount: CreateAccount, loadingView: LoadingView) {
        self.alertView = alertView
        self.emailValidator = emailValidator
        self.createAccount = createAccount
        self.loadingView = loadingView
    }
    
    public func signUp(viewModel: SignUpViewModel) {
        do {
            try validate(viewModel: viewModel)
        } catch let error as ValidationError {
            alertView.showMessage(viewModel: AlertViewModel(title: "Validation failed", message: error.message))
            return
        } catch {
            return
        }
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        createAccount.create(account: SignUpMapper.mapToCreateAccountModel(viewModel: viewModel)) {[weak self] result in
            guard let self = self else { return }
            self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
            switch result {
            case .failure: self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: "Something goes wrong"))
            case .success(_): self.alertView.showMessage(viewModel: AlertViewModel(title: "Success", message: "Cheers! Account created"))
            }
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
        } else if !emailValidator.isValid(email: viewModel.email!) {
            throw ValidationError.invalid_email
        }
        
    }
}

enum ValidationError: LocalizedError {
    
    case required_name, required_email, required_password, required_password_confirmation, password_not_match, invalid_email
    
    var message: String {
        switch self {
        case .required_name: return "Name is required"
        case .required_email: return "Email is required"
        case .required_password: return "Password is required"
        case .required_password_confirmation: return "Password confirmation is required"
        case .password_not_match: return "Password not match"
        case .invalid_email: return "Invalid email"
        }
    }
}
