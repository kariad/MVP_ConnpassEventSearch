//
//  SearchEventBuilder.swift
//  MVP_ConnpassEventSearch
//
//  Created by Daiki Katayama on 2019/04/13.
//  Copyright © 2019 Daiki Katayama. All rights reserved.
//

struct SearchEventBuilder {
    static func build() -> SearchEventViewController {
        let searchEventViewController = SearchEventViewController()
        let model = SearchEventModel(http: NetworkHttp())
        let presenter = SearchEventPresenter(viewControllr: searchEventViewController, model: model)
        searchEventViewController.inject(presenter: presenter)
        return searchEventViewController
    }
}
