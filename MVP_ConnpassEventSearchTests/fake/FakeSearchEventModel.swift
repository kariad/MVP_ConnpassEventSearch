//
//  FakeSearchEventModel.swift
//  MVP_ConnpassEventSearchTests
//
//  Created by Daiki Katayama on 2019/04/04.
//  Copyright © 2019 Daiki Katayama. All rights reserved.
//
@testable import MVP_ConnpassEventSearch

class FakeSearchEventModel: SearchEventModelProtocol {
    var search_arguments: String? = ""
    var search_callCount = 0
    var search_successValue = [ConnpassEvent]()
    func search(searchWord: String, completion: @escaping ((Result<[ConnpassEvent]>) -> ())) {
        search_callCount += 1
        search_arguments = searchWord
        completion(.success(search_successValue))
    }
}

class FakeFailureSearchEventModel: SearchEventModelProtocol {
    var search_arguments = ""
    func search(searchWord: String, completion: @escaping ((Result<[ConnpassEvent]>) -> ())) {
        search_arguments = searchWord
        completion(.failure)
    }
}
