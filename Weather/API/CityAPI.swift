//
//  CloseCities.swift
//  Weather
//
//  Created by user186640 on 12/2/20.
//

import Foundation
import IHProgressHUD
import  UIKit

struct CityAPI{
    
   
    static let shared = CityAPI()
    
    
    
    func  getCityDataFromApi( url: String, parameters: [String: String],completion : @escaping ([CityModel]) -> Void) {
        
        
            IHProgressHUD.show()
            
        var components = URLComponents(string: url + "search/")!
            components.queryItems = parameters.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            let request = URLRequest(url: components.url!)
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
           
         guard let data = data else {return}
         

         do {
            
            let postsResponse = try JSONDecoder().decode([CityModel].self, from: data)
        
             completion(postsResponse)
            
            IHProgressHUD.dismiss()
         } catch {
             print("Error decoding Json comments - \(error)")
            IHProgressHUD.dismiss()
         }
         
        }).resume()
     
        
        
       
        
    }
        
}
   
    
    
    
