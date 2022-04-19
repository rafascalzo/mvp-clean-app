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
        nameTextField.placeholder = "Name"
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordConfirmationTextField = UITextField()
        passwordConfirmationTextField.placeholder = "Password confirmation"
        saveButton = UIButton()
        saveButton.layer.cornerRadius = 8
        saveButton.addTarget(self, action: #selector(saveButtonDidTapped), for: .touchUpInside)
    }
    
    func setupView() {
        configureComponents()
        var constraints = [NSLayoutConstraint]()
        view.addSubview(nameTextField)
        constraints.append(nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20))
        constraints.append(nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(nameTextField.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(nameTextField.widthAnchor.constraint(equalToConstant: 130))
        view.addSubview(emailTextField)
        constraints.append(emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20))
        constraints.append(emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(emailTextField.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(emailTextField.widthAnchor.constraint(equalToConstant: 120))
        view.addSubview(passwordTextField)
        constraints.append(passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20))
        constraints.append(passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(passwordTextField.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(passwordTextField.widthAnchor.constraint(equalToConstant: 120))
        view.addSubview(passwordConfirmationTextField)
        constraints.append(passwordConfirmationTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20))
        constraints.append(passwordConfirmationTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(passwordConfirmationTextField.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(passwordConfirmationTextField.widthAnchor.constraint(equalToConstant: 120))
        view.addSubview(saveButton)
        constraints.append(saveButton.topAnchor.constraint(equalTo: passwordConfirmationTextField.bottomAnchor, constant: 20))
        constraints.append(saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(saveButton.heightAnchor.constraint(equalToConstant: 60))
        constraints.append(saveButton.widthAnchor.constraint(equalToConstant: 120))
        saveButton.addSubview(loadingIndicator)
        constraints.append(loadingIndicator.trailingAnchor.constraint(equalTo: loadingIndicator.superview!.trailingAnchor))
        constraints.append(loadingIndicator.centerYAnchor.constraint(equalTo: loadingIndicator.superview!.centerYAnchor))
        constraints.append(loadingIndicator.widthAnchor.constraint(equalToConstant: 25))
        constraints.append(loadingIndicator.heightAnchor.constraint(equalToConstant: 25))
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
