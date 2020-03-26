//
//  CityDetailViewController.swift
//  AirQuality ObjC
//
//  Created by theevo on 3/26/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

import UIKit

class CityDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var cityStateCountryDictionary: [String:String] = [:] {
        didSet {
            fetchCityDetails(forCityStateCountryDictionary: cityStateCountryDictionary)
        }
    }
    
    //    var cityAirQuality = TTVCityAirQuality()
    
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var stateNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var aqiLabel: UILabel!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Helper Functions
    
    func fetchCityDetails(forCityStateCountryDictionary dictionary: [String:String]) {
        
        guard let country = dictionary["country"],
            let city = dictionary["city"] else { return }
        
        let state = dictionary["state"] ?? ""
        
        TTVCityAirQualityController.fetchData(forCity: city, state: state, country: country) { (maybeCityAirQualityObject) in
            if let aqiObject = maybeCityAirQualityObject {
                self.updateUI(with: aqiObject)
            } else {
                print("Error: no air quality object!")
            }
        }
    } // end fetchCityDetails
    
    
    func updateUI(with cityAirQuality:TTVCityAirQuality) {
        
        DispatchQueue.main.async {
            self.cityNameLabel.text = cityAirQuality.city
            self.countryNameLabel.text = cityAirQuality.country
            self.stateNameLabel.text = cityAirQuality.state
            self.temperatureLabel.text = String(cityAirQuality.weather.temperature)
            self.humidityLabel.text = String(cityAirQuality.weather.humidity)
            self.windLabel.text = String(cityAirQuality.weather.windSpeed)
            self.aqiLabel.text = "\(cityAirQuality.pollution.airQualityIndex)"
            
        }
    }
    
} // end class



