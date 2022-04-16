//
//  SignUpMapper.swift
//  Presentation
//
//  Created by Rafael Scalzo on 16/04/22.
//

import Foundation
import Domain

final class SignUpMapper {
    
    static func mapToCreateAccountModel(viewModel: SignUpViewModel) -> CreateAccountModel {
        return CreateAccountModel(name: viewModel.name!, email: viewModel.email!, password: viewModel.password!, passwordConfirmation: viewModel.passwordConfirmation!)
    }
}
