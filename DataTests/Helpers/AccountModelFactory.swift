//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Rafael Scalzo on 13/04/22.
//

import Foundation
import Domain

func makeAccountModel() -> AccountModel {
    return AccountModel("any_id", name: "any_name", email: "any_email", password: "any_password")
}
