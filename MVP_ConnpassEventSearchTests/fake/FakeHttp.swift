//
//  FakeHttp.swift
//  MVP_ConnpassEventSearchTests
//
//  Created by Daiki Katayama on 2019/04/13.
//  Copyright © 2019 Daiki Katayama. All rights reserved.
//

@testable import MVP_ConnpassEventSearch
import Foundation

class FakeHttp : Http {
    var get_url: URL!
    var fixtures: Any?
    var httpStatusCode = 0
    var error: Error?
    func get(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let data = try? JSONSerialization.data(withJSONObject: fixtures!, options: [])
        get_url = url
        completion(
            data,
            HTTPURLResponse(
                url: URL(string: "test")!,
                statusCode: httpStatusCode,
                httpVersion: "",
                headerFields: nil
            ),
            error
        )
    }
}
