//
//  HttpError.swift
//  Data
//
//  Created by Rafael Scalzo on 12/04/22.
//

import Foundation
import CoreData

public enum HttpError: Error {
    
    case noConnectivity, badRequest, serverError, unauthorized, forbidden
}
