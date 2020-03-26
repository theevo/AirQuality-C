//
//  CityListTableViewController.swift
//  AirQuality ObjC
//
//  Created by theevo on 3/26/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

import UIKit

class CityListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var countryStateDictionary: [String: String] = [:]
    
    var cities: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let country = countryStateDictionary["country"] else { return }
        let state = countryStateDictionary["state"] ?? ""
        fetchCities(country: country, state: state)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        
        let city = cities[indexPath.row]
        
        cell.textLabel?.text = city
        
        return cell
    }
    
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCityDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? CityDetailViewController
                else { return }
            
            let selectedCity = cities[indexPath.row]
            let state = countryStateDictionary["state"]
            let country = countryStateDictionary["country"]
            
            destinationVC.cityStateCountryDictionary["city"] = selectedCity
            destinationVC.cityStateCountryDictionary["state"] = state
            destinationVC.cityStateCountryDictionary["country"] = country
        }
    }
    
    
    // MARK: - Helper Functions
    
    func fetchCities(country: String, state: String) {
        TTVCityAirQualityController.fetchSupportedCities(inState: state, country: country) { (maybeCities) in
            if let cities = maybeCities {
                self.cities = cities
            } else {
                print("Error: no cities!")
            }
        }
    }
    
} // end class
