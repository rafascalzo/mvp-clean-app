//
//  Model.swift
//  Domain
//
//  Created by Rafael Scalzo on 08/04/22.
//

import Foundation

public protocol Model: Codable, Equatable {}

public extension Model {
    
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    func toJson() -> [String: Any]? {
        guard let data = self.toData() else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
    }
}
