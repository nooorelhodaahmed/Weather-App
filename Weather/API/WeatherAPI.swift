//
//  WeatherAPI.swift
//  Weather
//
//  Created by user186640 on 12/2/20.
//

import Foundation
import UIKit
import  IHProgressHUD



struct WeatherAPI {
    
    
   static  let shred = WeatherAPI()
    
    
    
    func  fetchWeatherDataFromApi( url: String, parameters:[String],completion : @escaping ([WeatherModel]) -> Void) {
        
        
        IHProgressHUD.show()
            
           
             
            guard let url = URL(string: (url + parameters[0] + "/" + parameters[1] + "/")) else {return}
           
          
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
               
             guard let data = data else {return}
             

             do {
                
                let postsResponse = try JSONDecoder().decode([WeatherModel].self, from: data)
               
              
                 completion(postsResponse)
              
                IHProgressHUD.dismiss()
             } catch {
                 print("Error decoding Json comments - \(error)")
                IHProgressHUD.dismiss()
             }
             
            }).resume()
        
       
    }
    
   

}

