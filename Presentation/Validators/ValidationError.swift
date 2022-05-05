//
//  ValidationError.swift
//  Presentation
//
//  Created by Rafael Scalzo on 26/04/22.
//

import Foundation

public enum ValidationError: LocalizedError {
    
    case required_name, required_email, required_password, required_password_confirmation, password_not_match, invalid_email
    
    public var message: String {
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


extension ValidationError {
    
    public var fieldLabel: String? {
        switch self {
        case .required_name: return "name"
        default: return nil
        }
    }
}



