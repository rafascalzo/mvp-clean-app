//
//  Validation.swift
//  Presentation
//
//  Created by Rafael Scalzo on 26/04/22.
//

import Foundation

public protocol Validation {
    func validate(data: [String:Any]?) throws
}
