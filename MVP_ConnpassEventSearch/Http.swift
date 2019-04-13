//
//  Http.swift
//  MVP_ConnpassEventSearch
//
//  Created by Daiki Katayama on 2019/04/13.
//  Copyright © 2019 Daiki Katayama. All rights reserved.
//

import Foundation

protocol Http {
    func get(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
}

class NetworkHttp: Http {
    func get(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }
        task.resume()
    }
}
