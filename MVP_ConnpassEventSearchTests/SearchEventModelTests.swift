//
//  SearchEventModelTests.swift
//  MVP_ConnpassEventSearchTests
//
//  Created by Daiki Katayama on 2019/04/13.
//  Copyright © 2019 Daiki Katayama. All rights reserved.
//

@testable import MVP_ConnpassEventSearch
import XCTest
import XCTestExtensions

class SearchEventModelTests: XCTestCase {
    let defaultEvents = [
        ConnpassEvent(
            title: "ARIA",
            catchCopy: "ヒーリングアニメ",
            eventUrl: "",
            startedAt: "2019-04-14T011:00:00+09:00"
        )
    ]
    func test_serachのテスト() {
        XCTContext.runActivity(named: "searchWordがARIAだった時にURLが正しいこと") { _ in
            let fakeHttp = FakeHttp()
            let subject = SearchEventModel(http: fakeHttp)
            fakeHttp.fixtures = SearchEventFixtures.defaultFixture
            fakeHttp.httpStatusCode = 200
            fakeHttp.error = nil

            subject.search(searchWord: "ARIA", completion: { _ in })

            XCTAssertEqual(fakeHttp.get_url.absoluteString, "https://connpass.com/api/v1/event/?keyword=ARIA&count=20")
        }

        XCTContext.runActivity(named: "getに成功した時completionのsuccessが呼ばれること") { _ in
            let fakeHttp = FakeHttp()
            let subject = SearchEventModel(http: fakeHttp)
            fakeHttp.fixtures = SearchEventFixtures.defaultFixture
            fakeHttp.httpStatusCode = 200
            fakeHttp.error = nil
            var actualResult: Result<[ConnpassEvent]>!

            subject.search(searchWord: "ARIA") { result in
                actualResult = result
            }

            XCTAssertEqual(actualResult, .success(defaultEvents))
        }

        XCTContext.runActivity(named: "getに失敗した時completionのfailureが呼ばれること") {
            _ in
            XCTContext.runActivity(named: "decodeに失敗した時") { _ in
                let fakeHttp = FakeHttp()
                let subject = SearchEventModel(http: fakeHttp)
                fakeHttp.fixtures = []
                fakeHttp.httpStatusCode = 200
                fakeHttp.error = nil
                var actualResult: Result<[ConnpassEvent]>!

                subject.search(searchWord: "ARIA") { result in
                    actualResult = result
                }

                XCTAssertEqual(actualResult, .failure)
            }

            XCTContext.runActivity(named: "errorがnilではなかった時") { _ in
                let fakeHttp = FakeHttp()
                let subject = SearchEventModel(http: fakeHttp)
                fakeHttp.fixtures = SearchEventFixtures.defaultFixture
                fakeHttp.httpStatusCode = 200
                fakeHttp.error = NSError()
                var actualResult: Result<[ConnpassEvent]>!

                subject.search(searchWord: "ARIA") { result in
                    actualResult = result
                }

                XCTAssertEqual(actualResult, .failure)
            }

            XCTContext.runActivity(named: "dataがnilだった時") { _ in
                let fakeHttp = FakeHttp()
                let subject = SearchEventModel(http: fakeHttp)
                fakeHttp.fixtures = ["test": "test",]
                fakeHttp.httpStatusCode = 200
                fakeHttp.error = NSError()
                var actualResult: Result<[ConnpassEvent]>!

                subject.search(searchWord: "ARIA") { result in
                    actualResult = result
                }

                XCTAssertEqual(actualResult, .failure)
            }

            XCTContext.runActivity(named: "status codeが404だった時") { _ in
                let fakeHttp = FakeHttp()
                let subject = SearchEventModel(http: fakeHttp)
                fakeHttp.fixtures = SearchEventFixtures.defaultFixture
                fakeHttp.httpStatusCode = 404
                fakeHttp.error = nil
                var actualResult: Result<[ConnpassEvent]>!

                subject.search(searchWord: "ARIA") { result in
                    actualResult = result
                }

                XCTAssertEqual(actualResult, .failure)
            }
        }
    }
}
