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
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
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
