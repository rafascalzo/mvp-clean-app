//
//  HttpClientSpy.swift
//  DataTests
//
//  Created by Rafael Scalzo on 13/04/22.
//

import Foundation
import Data

class HttpClientSpy: HttpClientPost {
    
    init() { }
    
    var urls = [URL]()
    var data: Data?
    var completion: ((Result<Data, HttpError>) -> Void)?
    
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void) {
        self.urls.append(url)
        self.data = data
        self.completion = completion
    }
    
    func completeWithError(_ error: HttpError) {
        completion?(.failure(error))
    }
    
    func completeWithData(_ data: Data) {
        completion?(.success(data))
    }
}
