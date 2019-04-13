//
//  SearchEventPresenterTests.swift
//  MVP_ConnpassEventSearchTests
//
//  Created by Daiki Katayama on 2019/04/04.
//  Copyright © 2019 Daiki Katayama. All rights reserved.
//
@testable import MVP_ConnpassEventSearch
import XCTest
import XCTestExtensions

class SearchEventPresenterTests: XCTestCase {
    let defaultEvent = ConnpassEvent(
        title: "ARIA",
        catchCopy: "ヒーリングアニメ",
        eventUrl: "aria.com",
        startedAt: "2019-04-14T11:00:00+09:00"
    )

    func test_didTapSearchButtonのテスト() {
        XCTContext.runActivity(named: "引数のtextがnilの時modelのsearchが呼ばれないこと") { _ in
            let fakeViewController = FakeSearchEventViewController()
            let fakeModel = FakeSearchEventModel()
            let subject = SearchEventPresenter(
                viewControllr: fakeViewController, model: fakeModel
            )

            subject.didTapSearchButton(text: nil)

            XCTAssertEqual(fakeModel.search_callCount, 0)
        }

        XCTContext.runActivity(named: "引数のtextが空文字の時modelのsearchが呼ばれないこと") { _ in
            let fakeViewController = FakeSearchEventViewController()
            let fakeModel = FakeSearchEventModel()
            let subject = SearchEventPresenter(
                viewControllr: fakeViewController, model: fakeModel
            )

            subject.didTapSearchButton(text: "")

            XCTAssertEqual(fakeModel.search_callCount, 0)
        }

        XCTContext.runActivity(named: "検索に成功した時updateTableViewが呼ばれること") { _ in
            let fakeViewController = FakeSearchEventViewController()
            let fakeModel = FakeSearchEventModel()
            let subject = SearchEventPresenter(
                viewControllr: fakeViewController, model: fakeModel
            )
            fakeModel.search_successValue = [defaultEvent]

            subject.didTapSearchButton(text: "ARIA")

            XCTAssertEqual(fakeModel.search_arguments, "ARIA")
            XCTAssertEqualEventually(
                fakeViewController.updateTableView_arguments, [self.defaultEvent]
            )
        }

        XCTContext.runActivity(named: "エラーが起きた時displayErrorが呼ばれること") { _ in
            let fakeViewController = FakeSearchEventViewController()
            let fakeModel = FakeFailureSearchEventModel()
            let subject = SearchEventPresenter(
                viewControllr: fakeViewController, model: fakeModel
            )

            subject.didTapSearchButton(text: "test")

            XCTAssertEqualEventually(fakeViewController.displayError_callCount, 1)
        }
    }
}
