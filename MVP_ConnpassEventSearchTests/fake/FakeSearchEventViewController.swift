//
//  FakeSearchEventViewController.swift
//  MVP_ConnpassEventSearchTests
//
//  Created by Daiki Katayama on 2019/04/04.
//  Copyright © 2019 Daiki Katayama. All rights reserved.
//

@testable import MVP_ConnpassEventSearch

class FakeSearchEventViewController: SearchEventViewControllerProtocol {
    var updateTableView_arguments = [ConnpassEvent]()
    func updateTableView(events: [ConnpassEvent]) {
        updateTableView_arguments = events
    }

    var displayError_callCount = 0
    func displayError() {
        displayError_callCount += 1
    }
}
