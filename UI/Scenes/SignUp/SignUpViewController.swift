//
//  SignUpViewController.swift
//  UI
//
//  Created by Rafael Scalzo on 16/04/22.
//

import Foundation
import UIKit
import Presentation

final class SignUpViewController: UIViewController {
    
    var loadingIndicator: UIActivityIndicatorView!
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var passwordConfirmationTextField: UITextField!
    var saveButton: UIButton!
    var signUp: ((SignUpViewModel) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func configureComponents() {
        loadingIndicator = UIActivityIndicatorView(style: .medium)
        loadingIndicator.hidesWhenStopped = true
        nameTextField = UITextField()
        emailTextField = UITextField()
        passwordTextField = UITextField()
        passwordConfirmationTextField = UITextField()
        saveButton = UIButton()
        saveButton.addTarget(self, action: #selector(saveButtonDidTapped), for: .touchUpInside)
    }
    
    func setupView() {
        configureComponents()
        view.addSubview(loadingIndicator)
        var constraints = [NSLayoutConstraint]()
        constraints.append(loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        constraints.append(loadingIndicator.widthAnchor.constraint(equalToConstant: 20))
        constraints.append(loadingIndicator.heightAnchor.constraint(equalToConstant: 20))
        view.addSubview(saveButton)
        constraints.append(saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 30))
        constraints.append(saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(saveButton.heightAnchor.constraint(equalToConstant: 30))
        constraints.append(saveButton.widthAnchor.constraint(equalToConstant: 30))
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func saveButtonDidTapped() {
        let viewModel = SignUpViewModel(name: nameTextField.text, email: emailTextField.text, password: passwordTextField.text, passwordConfirmation: passwordConfirmationTextField.text)
        signUp?(viewModel)
    }
}

extension SignUpViewController: LoadingView {
    
    func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
}

extension SignUpViewController: AlertView {
    
    func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
