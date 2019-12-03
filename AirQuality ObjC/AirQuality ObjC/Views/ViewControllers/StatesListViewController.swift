//
//  StatesListViewController.swift
//  AirQuality ObjC
//
//  Created by RYAN GREENBURG on 11/21/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class StatesListViewController: UIViewController {
    // MARK: - Properties
    private enum Section{
        case main
    }
    var country: String?
    var states: [String] = [] {
        didSet {
            updateDataSource(with: self.states, animated: false)
        }
    }
    private var dataSource: UITableViewDiffableDataSource<Section, String>?
    let searchController = UISearchController()
    var filteredData: [String] = []

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()
        searchController.setupSearchControllerWith(self)
        navigationItem.searchController = searchController
        guard let country = country else { return }
        DVMCityAirQualityController.fetchSupportedStates(inCountry: country) { (states) in
            if let states = states {
                self.states = states
            }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCitiesVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let country = country,
                let destinationVC = segue.destination as? CitiesListViewController
                else { return}
            let selectedState = searchController.searchIsActive ? filteredData[indexPath.row] : states[indexPath.row]
            destinationVC.country = country
            destinationVC.state = selectedState
        }
    }
    
    // MARK: - Class Methods
    func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, state) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
            cell.textLabel?.text = state
            return cell
        })
    }
    
    func updateDataSource(with items: [String], animated: Bool) {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
            snapshot.appendSections([.main])
            snapshot.appendItems(items, toSection: .main)
            self.dataSource?.apply(snapshot)
        }
    }
}

extension StatesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let searchBarText = searchBar.text, !searchBarText.isEmpty else {
            updateDataSource(with: states, animated: true)
            return
        }
        filteredData = searchController.filer(states, by: searchBarText)
        updateDataSource(with: filteredData, animated: true)
    }
}
