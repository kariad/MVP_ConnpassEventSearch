//
//  FakeSearchEventPresenter.swift
//  MVP_ConnpassEventSearchTests
//
//  Created by Daiki Katayama on 2019/04/04.
//  Copyright © 2019 Daiki Katayama. All rights reserved.
//

@testable import MVP_ConnpassEventSearch

class FakeSearchEventPresenter: SearchEventPresenterProtocol {
    var didTapSearchButton_arguments: String?
    func didTapSearchButton(text: String?) {
        didTapSearchButton_arguments = text
    }
}
