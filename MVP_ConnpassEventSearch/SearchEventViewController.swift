//
//  ViewController.swift
//  MVP_ConnpassEventSearch
//
//  Created by Daiki Katayama on 2019/03/31.
//  Copyright © 2019 Daiki Katayama. All rights reserved.
//

import UIKit
import PureLayout

protocol SearchEventViewControllerProtocol: AnyObject {
    func updateTableView(events: [ConnpassEvent])
    func displayError()
}

class SearchEventViewController: UIViewController {
    let searchBar = UISearchBar(frame: .zero)
    let tableview = UITableView(frame: .zero, style: .grouped)
    private(set) var events = [ConnpassEvent]()
    let eventCellIdentifier = "eventCell"

    private var presenter: SearchEventPresenterProtocol!

    func inject(presenter: SearchEventPresenterProtocol) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addSubviews()
        self.configureSubviews()
        self.addConstraints()
    }

    func addSubviews() {
        self.view.addSubview(self.tableview)
    }

    func configureSubviews() {
        self.view.backgroundColor = .white
        self.navigationItem.titleView = self.searchBar
        self.searchBar.delegate = self
        self.searchBar.showsCancelButton = true
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.register(EventCell.self, forCellReuseIdentifier: self.eventCellIdentifier)
    }

    func addConstraints() {
        self.tableview.autoPinEdgesToSuperviewEdges()
    }
}

extension SearchEventViewController: SearchEventViewControllerProtocol {
    func updateTableView(events: [ConnpassEvent]) {
        self.events = events
        tableview.reloadData()
    }

    func displayError() {
        // エラー時の処理
    }
}

extension SearchEventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: self.eventCellIdentifier) as! EventCell
        cell.configureCell(self.events[indexPath.row])
        return cell
    }
}

extension SearchEventViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

extension SearchEventViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.didTapSearchButton(text: searchBar.text)
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
