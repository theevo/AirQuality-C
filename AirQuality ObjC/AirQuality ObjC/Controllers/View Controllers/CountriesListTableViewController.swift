//
//  CountriesListTableViewController.swift
//  AirQuality ObjC
//
//  Created by theevo on 3/25/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

import UIKit

class CountriesListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var countries: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCountries()
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        
        let countryName = countries[indexPath.row]
        
        cell.textLabel?.text = countryName
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // IIDOO
        
        if segue.identifier == "toStatesVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? StatesListTableViewController
            
            else { return }
            
            let selectedCountry = countries[indexPath.row]
            destinationVC.country = selectedCountry
        }
        
        
    }
    
    // MARK: - Helper Functions
    
    func fetchCountries() {
        TTVCityAirQualityController.fetchSupportedCountries { (maybeCountries) in
            if let countries = maybeCountries {
                self.countries = countries
            } else {
                print("Error: no countries")
            }
        }
    }
    
}
