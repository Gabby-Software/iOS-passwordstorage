//
//  PasswordsViewController.swift
//  passAutoFillExtension
//
//  Created by Sun, Mingshen on 12/31/20.
//  Copyright © 2020 Bob Sun. All rights reserved.
//

import UIKit
import AuthenticationServices
import passKit

class PasswordsViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    var dataSource: PasswordsTableDataSource!
    weak var selectionDelegate: PasswordSelectionDelegate?

    lazy var searchController: UISearchController = {
        let uiSearchController = UISearchController(searchResultsController: nil)
        uiSearchController.searchBar.isTranslucent = true
        uiSearchController.obscuresBackgroundDuringPresentation = false
        uiSearchController.searchBar.sizeToFit()
        if #available(iOS 13.0, *) {
            uiSearchController.searchBar.searchTextField.clearButtonMode = .whileEditing
        }
        return uiSearchController
    }()

    lazy var searchBar: UISearchBar = {
        self.searchController.searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        searchBar.delegate = self

        tableView.delegate = self
        tableView.dataSource = dataSource
    }

    func showPasswordsWithSuggstion(_ keywords: [String]) {
        dataSource.showTableEntriesWithSuggestion(matching: keywords)
        tableView.reloadData()
    }

    @IBAction
    private func cancel(_: AnyObject?) {
        self.extensionContext?.cancelRequest(withError: NSError(domain: ASExtensionErrorDomain, code: ASExtensionError.userCanceled.rawValue))
        self.dismiss(animated: true)
    }
}

extension PasswordsViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        dataSource.showTableEntries(matching: searchText)
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_: UISearchBar) {
        dataSource.showTableEntries(matching: "")
        tableView.reloadData()
    }
}

extension PasswordsViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var entry: PasswordTableEntry!
        if dataSource.showSuggestion {
            if indexPath.section == 0 {
                entry = dataSource.suggestedPasswordsTableEntries[indexPath.row]
            } else {
                entry = dataSource.otherPasswordsTableEntries[indexPath.row]
            }
        } else {
            entry = dataSource.filteredPasswordsTableEntries[indexPath.row]
        }

        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        self.selectionDelegate?.selected(password: entry)
    }
}
