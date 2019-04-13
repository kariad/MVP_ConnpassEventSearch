//
//  SearchEventModel.swift
//  MVP_ConnpassEventSearch
//
//  Created by Daiki Katayama on 2019/04/04.
//  Copyright © 2019 Daiki Katayama. All rights reserved.
//
import Foundation

protocol SearchEventModelProtocol {
    func search(searchWord: String, completion: @escaping ((Result<[ConnpassEvent]>) -> ()))
}

class SearchEventModel: SearchEventModelProtocol {
    let http: Http

    init(http: Http) {
        self.http = http
    }

    func search(searchWord: String, completion: @escaping (Result<[ConnpassEvent]>) -> ()) {
        var components = URLComponents(string: "https://connpass.com/api/v1/event/")!
        components.queryItems = [
            URLQueryItem(name: "keyword", value: searchWord),
            URLQueryItem(name: "count", value: "20")
        ]

        http.get(url: components.url!) {
            maybeData, maybeResponse, maybeError in
            guard
                maybeError == nil,
                let data = maybeData,
                let response = maybeResponse as? HTTPURLResponse,
                response.statusCode == 200
            else {
                    completion(.failure)
                    return
            }

            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(response.events))
            } catch {
                completion(.failure)
            }
        }
    }
}

