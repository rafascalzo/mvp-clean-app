//
//  DataExtensions.swift
//  Data
//
//  Created by Rafael Scalzo on 13/04/22.
//

import Foundation

public extension Data {
    
    func toModel<T:Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
    
    func toJson() -> [String:Any]? {
        return try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String:Any]
    }
}
