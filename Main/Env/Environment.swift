//
//  Environment.swift
//  Main
//
//  Created by Rafael Scalzo on 24/04/22.
//

import Foundation

public final class Environment {
    
    public enum EnvironmentVariable: String {
        case apiBaseURL = "API_BASE_URL"
    }
    
    public static func variable(for key: EnvironmentVariable) -> String {
        return Bundle.main.infoDictionary?[key.rawValue] as! String
    }
}
