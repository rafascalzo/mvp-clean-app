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
    private let createAccount: CreateAccount
    private let loadingView: LoadingView
    private let validation: Validation
    
    public init(alertView: AlertView, createAccount: CreateAccount, loadingView: LoadingView, validation: Validation) {
        self.alertView = alertView
        self.createAccount = createAccount
        self.loadingView = loadingView
        self.validation = validation
    }
    
    public func signUp(viewModel: SignUpViewModel) {
        do {
            try validation.validate(data: viewModel.toJson())
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
}


