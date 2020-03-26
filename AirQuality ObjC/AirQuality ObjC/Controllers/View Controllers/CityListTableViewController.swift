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
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
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
