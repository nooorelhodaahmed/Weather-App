//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by user186640 on 11/29/20.
//

import Foundation

struct CityViewModel {
    
    let city : CityModel
   
    
    init(city:CityModel){
        
        self.city = city
        
    }
  
    
    var cityName : String? {
        
        return city.title
    
    }
    
  
    
}
