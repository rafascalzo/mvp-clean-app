//
//  SignUpViewController.swift
//  UI
//
//  Created by Rafael Scalzo on 16/04/22.
//

import Foundation
import UIKit
import Presentation

public final class SignUpViewController: UIViewController {
    
    var loadingIndicator: UIActivityIndicatorView!
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var passwordConfirmationTextField: UITextField!
    var saveButton: UIButton!
    public var signUp: ((SignUpViewModel) -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .white
        nameTextField = UITextField()
        nameTextField.placeholder = "Name"
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordConfirmationTextField = UITextField()
        passwordConfirmationTextField.placeholder = "Password confirmation"
        passwordConfirmationTextField.isSecureTextEntry = true
        saveButton = UIButton()
        saveButton.layer.cornerRadius = 4
        saveButton.setTitle("Sign Up", for: .normal)
        saveButton.backgroundColor = .lightGray
        saveButton.addTarget(self, action: #selector(saveButtonDidTapped), for: .touchUpInside)
        loadingIndicator = UIActivityIndicatorView(style: .medium)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        applyConstraints()
        hideKeyboardOnTap()
    }
    
    @objc private func hideKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func applyConstraints() {
        var constraints = [NSLayoutConstraint]()
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20))
        constraints.append(nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16))
        constraints.append(nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16))
        constraints.append(nameTextField.heightAnchor.constraint(equalToConstant: 50))
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20))
        constraints.append(emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16))
        constraints.append(emailTextField.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16))
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20))
        constraints.append(passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16))
        constraints.append(passwordTextField.heightAnchor.constraint(equalToConstant: 50))
        view.addSubview(passwordConfirmationTextField)
        passwordConfirmationTextField.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(passwordConfirmationTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20))
        constraints.append(passwordConfirmationTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16))
        constraints.append(passwordConfirmationTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16))
        constraints.append(passwordConfirmationTextField.heightAnchor.constraint(equalToConstant: 50))
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(saveButton.topAnchor.constraint(equalTo: passwordConfirmationTextField.bottomAnchor, constant: 20))
        constraints.append(saveButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16))
        constraints.append(saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16))
        constraints.append(saveButton.heightAnchor.constraint(equalToConstant: 60))
        saveButton.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(loadingIndicator.trailingAnchor.constraint(equalTo: loadingIndicator.superview!.trailingAnchor, constant: -10))
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
    
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
            loadingIndicator.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            loadingIndicator.stopAnimating()
        }
    }
}

extension SignUpViewController: AlertView {
    
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
