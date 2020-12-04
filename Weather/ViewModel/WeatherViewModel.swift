//
//  CityWeatherViewModel.swift
//  WeatherApp
//
//  Created by user186640 on 11/30/20.
//

import Foundation
import UIKit


struct WeatherViewModel {
    
    let weather : WeatherModel
    
    init(weather:WeatherModel){
        self.weather = weather
    }
    
    
    var cityTemp: Int? {
        return Int((weather.the_temp)!)
    }
    var cityName : String {
        return (weather.applicable_date ?? "")
    }
    var lowTemprature : Int {
        return Int(weather.min_temp ?? 0)
    }
    var highTemprature : Int {
        return Int(weather.max_temp ?? 0)
    }
    
    var windSpeed : Int {
        return Int(weather.wind_speed ?? 0)
    }
    var humdity : Int {
        return Int (weather.humidity ?? 0)
    }
    var visiabilty : Int {
        return Int(weather.visibility ?? 0)
    }
    var date : String {
        
        return (weather.created ?? "").substring(0..<10)
    }
    
    var abbreviation : String {
        
        return weather.weather_state_abbr ?? ""
    }
   
 
    
    
}
