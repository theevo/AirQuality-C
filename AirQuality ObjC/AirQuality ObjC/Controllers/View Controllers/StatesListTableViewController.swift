//
//  StatesListTableViewController.swift
//  AirQuality ObjC
//
//  Created by theevo on 3/26/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

import UIKit

class StatesListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var country: String? {
        didSet {
            guard let country = country else { return }
            fetchStates(country)
        }
    }
    
    var states: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        
        let state = states[indexPath.row]
        
        cell.textLabel?.text = state

        return cell
    }

   

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCityVCfromState" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? CityListTableViewController
                else { return }
            
            let selectedState = states[indexPath.row]
            
            destinationVC.countryStateDictionary["state"] = selectedState
            destinationVC.countryStateDictionary["country"] = country
        }
    }
    
    
    // MARK: - Helper Functions
    
    func fetchStates(_ country: String){
        TTVCityAirQualityController.fetchSupportedStates(inCountry: country) { (maybeStates) in
            if let states = maybeStates {
                self.states = states
            } else {
                print("Error: no states!")
            }
            
            
            
            // TO DO: there will be a condition where maybeStates is empty like in the case of Brazil, which has no states. need to find a way to fill states array with just 1 placeholder state that says "click to continue to Brazil's cities"
        }
    }

} // end class
