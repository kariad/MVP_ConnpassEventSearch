//
//  SearchEventViewControllerTests.swift
//  MVP_ConnpassEventSearchTests
//
//  Created by Daiki Katayama on 2019/04/04.
//  Copyright © 2019 Daiki Katayama. All rights reserved.
//

@testable import MVP_ConnpassEventSearch
import XCTest

class SearchEventViewControllerTests: XCTestCase {
    func test_searchボタンを押した時検索が行われる() {
        XCTContext.runActivity(
            named: "PresenterのdidTapSearchButtonが呼ばれること"
        ) { _ in
            let subject = SearchEventViewController()
            let fakePresenter = FakeSearchEventPresenter()
            subject.inject(presenter: fakePresenter)
            let searchBar = UISearchBar()
            searchBar.text = "hogehoge"

            subject.searchBarSearchButtonClicked(searchBar)

            XCTAssertEqual(fakePresenter.didTapSearchButton_arguments, "hogehoge")
        }
    }

    func test_updateTableViewが呼ばれた時にイベントが表示される() {
        let events = [
            ConnpassEvent(
                title: "title1",
                catchCopy: "",
                eventUrl: "",
                startedAt: ""
            ),
            ConnpassEvent(
                title: "title2",
                catchCopy: "",
                eventUrl: "",
                startedAt: ""
            ),
        ]
        XCTContext.runActivity(
            named: "eventプロパティが更新されること"
        ) { _ in
            let subject = SearchEventViewController()
            let fakePresenter = FakeSearchEventPresenter()
            subject.inject(presenter: fakePresenter)

            subject.updateTableView(events: events)

            XCTAssertEqual(subject.events, events)
        }

        XCTContext.runActivity(
            named: "tableViewのセルが更新されること"
        ) { _ in
            let subject = SearchEventViewController()
            let fakePresenter = FakeSearchEventPresenter()
            subject.inject(presenter: fakePresenter)
            subject.loadViewIfNeeded()
            XCTAssertEqual(subject.tableview.numberOfRows(inSection: 0), 0)

            subject.updateTableView(events: events)

            XCTAssertEqual(subject.tableview.numberOfRows(inSection: 0), 2)
        }
    }
}
