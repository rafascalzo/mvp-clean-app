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
    var saveButton: UIButton!
    var signUp: ((SignUpViewModel) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc private func saveButtonDidTapped() {
        signUp?(SignUpViewModel(name: nil, email: nil, password: nil, passwordConfirmation: nil))
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
    
    func configureComponents() {
        loadingIndicator = UIActivityIndicatorView(style: .medium)
        loadingIndicator.hidesWhenStopped = true
        saveButton = UIButton()
        saveButton.addTarget(self, action: #selector(saveButtonDidTapped), for: .touchUpInside)
    }
}

extension UIControl {
    
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach({ action in
                (target as NSObject).perform(Selector(action))
            })
        }
    }
    
    func simulateTap() {
        simulate(event: .touchUpInside)
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
    
    func showMessage(viewModel: AlertViewModel) { }
}
