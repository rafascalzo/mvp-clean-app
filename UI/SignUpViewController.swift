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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        loadingIndicator = UIActivityIndicatorView(style: .medium)
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
        var constraints = [NSLayoutConstraint]()
        constraints.append(loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        constraints.append(loadingIndicator.widthAnchor.constraint(equalToConstant: 20))
        constraints.append(loadingIndicator.heightAnchor.constraint(equalToConstant: 20))
        NSLayoutConstraint.activate(constraints)
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
