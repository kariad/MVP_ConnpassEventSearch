//
//  ConnpassEvent.swift
//  MVP_ConnpassEventSearch
//
//  Created by Daiki Katayama on 2019/04/03.
//  Copyright © 2019 Daiki Katayama. All rights reserved.
//

struct ConnpassEvent: Codable, Equatable {
    var title: String
    var catchCopy: String
    var eventUrl: String
    var startedAt: String

    enum CodingKeys: String, CodingKey {
        case title
        case catchCopy = "catch"
        case eventUrl = "event_url"
        case startedAt = "started_at"
    }
}

struct Response: Codable {
    var events: [ConnpassEvent]
}


