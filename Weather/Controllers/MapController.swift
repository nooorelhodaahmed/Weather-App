//
//  MapControllerViewController.swift
//  Weather
//
//  Created by user186640 on 12/2/20.
//

import UIKit
import MapKit
import CoreLocation




class MapController: UIViewController {

    
    var cityList = [CityModel]() {
        
        
        didSet {
            
            DispatchQueue.main.async { [self] in
            
                let secondTab = (self.tabBarController?.viewControllers![1])! as? CityController
                secondTab?.cityList = self.cityList
                
            }
          
            
        }
    }
    
     private let mapView = MKMapView()
     private var manager = CLLocationManager()
     private var locations = [CLLocation]()
     
     
     //MARK:- LifeCycle
     override func viewDidLoad() {
         super.viewDidLoad()
         
         configureUI()
       
     }

    
 //MARK:- API
     
   
    
    
    func fetchCloseCities(param : String ) {
        
        if connectedToNetwork() {
            CityAPI.shared.getCityDataFromApi(url: EndPiont.strUrl, parameters:["lattlong":param] ) { cityList in
               
                self.cityList = cityList
               
            }
        }
        
        else {
            let alert = UIAlertController(title: "Warning", message: "Please Check your internet connections", preferredStyle: UIAlertController.Style.alert)
                
                   alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                   self.present(alert, animated: true, completion:nil)
            
         }
      
    
    }
   
    
   

 //MARK:- Helper

     func configureUI(){
         
         mapView.frame = CGRect(x: 0, y: 10, width: 500, height: 800)
        
         view.addSubview(mapView)
         mapView.showsUserLocation = true
         mapView.userTrackingMode = .follow
         checkLocationServices ()
         
     }
     
     func checkLocationServices () {
         
         if CLLocationManager.locationServicesEnabled() {
             setUpManager()
         }
        
     }
     
     func setUpManager() {
         
         manager.desiredAccuracy = kCLLocationAccuracyBest
         manager.delegate = self
         manager.requestWhenInUseAuthorization()
         manager.startUpdatingLocation()
     }




 }

 //MARK:- CLLocationManagerDelegate


 extension MapController : CLLocationManagerDelegate {
     
     func render (_ location: CLLocation){
         
         let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
         let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
         
         let region = MKCoordinateRegion(center: coordinate, span: span)
         mapView.setRegion(region, animated: true)
         
      }
     
     
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         if let location = locations.last {
             manager.stopUpdatingLocation()
             render(location)
             let latlong = String(location.coordinate.latitude) + "," + String(location.coordinate.longitude)
            
            
                fetchCloseCities(param: latlong)
         
       
         }
         
        
     }
        
     func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
         
     }
 }

     

    


