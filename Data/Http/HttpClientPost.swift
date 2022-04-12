//
//  HttpClientPost.swift
//  Data
//
//  Created by Rafael Scalzo on 08/04/22.
//

import Foundation

public protocol HttpClientPost {
    func post(to url: URL, with data: Data?, completion: @escaping (HttpError) -> Void)
}
