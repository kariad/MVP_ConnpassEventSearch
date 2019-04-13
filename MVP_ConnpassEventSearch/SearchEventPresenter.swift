//
//  Presenter.swift
//  MVP_ConnpassEventSearch
//
//  Created by Daiki Katayama on 2019/04/04.
//  Copyright © 2019 Daiki Katayama. All rights reserved.
//
import Foundation

protocol SearchEventPresenterProtocol {
    func didTapSearchButton(text: String?)
}

class SearchEventPresenter: SearchEventPresenterProtocol {
    weak var viewController: SearchEventViewControllerProtocol?
    let model: SearchEventModelProtocol

    init(viewControllr: SearchEventViewControllerProtocol, model: SearchEventModelProtocol) {
        self.viewController = viewControllr
        self.model = model
    }

    func didTapSearchButton(text: String?) {
        guard
            let searchWord = text,
            searchWord.isEmpty == false
        else { return }

        model.search(searchWord: searchWord) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let events):
                DispatchQueue.main.async {
                    self.viewController?.updateTableView(events: events)
                }
            case .failure:
                DispatchQueue.main.async {
                    self.viewController?.displayError()
                }
            }
        }
    }
}
