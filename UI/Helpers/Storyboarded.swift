//
//  Storyboarded.swift
//  UI
//
//  Created by Rafael Scalzo on 18/04/22.
//

import Foundation
import UIKit

public protocol Storyboarded {
    func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    
    public static func instantiateWithStoryboard() -> Self {
        let vcName = String(describing: self)
        let sbName = vcName.components(separatedBy: "ViewController")[0]
        let bundle = Bundle(for: Self.self)
        let sb = UIStoryboard(name: sbName, bundle: bundle)
        return sb.instantiateViewController(withIdentifier: vcName) as! Self
    }
}
