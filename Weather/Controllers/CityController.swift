//
//  CityWeatherViewController.swift
//  WeatherApp
//
//  Created by user186640 on 11/27/20.
//

import UIKit



private let reuseIdentifier = "CityCell"

class CityController: UICollectionViewController {
   
    
    //MARK:- Proporties
    
    
    var cityList = [CityModel]()
  
        
       
 
    //MARK:-LifeCycle


    override func viewDidLoad() {
        super.viewDidLoad()
    
       
        configureCollectionView()
        
      
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK:-Hellpers
   
    
    
    func configureCollectionView(){
        collectionView.backgroundColor = .paleGrey
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CityCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    
    }
    
    
    
    //MARK:- API
    
    func fetchWeather(woeid: Int){
        if connectedToNetwork() {
            var date = Date.getCurrentDate()
            
            WeatherAPI.shred.fetchWeatherDataFromApi(url: EndPiont.strUrl, parameters: [String(woeid),date]) { weatherData in
                
                DispatchQueue.main.async {
                    self.pushWeatherController(parms:weatherData)
                }
               
            }
            
        }
        
        else {
            let alert = UIAlertController(title: "Warning", message: "Please Check your internet connections", preferredStyle: UIAlertController.Style.alert)
                
                   alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                   self.present(alert, animated: true, completion:nil)
            
        }
       
    }
    
    
    func pushWeatherController(parms :[WeatherModel]) {
        let newController = UINavigationController(rootViewController: WeatherController(weatherData: parms ))
        
        newController.modalPresentationStyle = .fullScreen
      
        self.present(newController, animated: true, completion: nil)    }
    
    //MARK:- Selector
 
    
}

    
    //MARK:- UICollectionViewDataSource

    extension CityController {
        
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return cityList.count
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            

            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CityCell
            
        
           cell.city = cityList[indexPath.row]
        
            return cell
        
        }
        
        override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
            guard let woeid = cityList[indexPath.row].woeid else {return}
            fetchWeather(woeid: woeid)
        }
        
        
   }

//MARK:- UICollectionDelegateFlowLayout

    extension CityController: UICollectionViewDelegateFlowLayout {
           
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
                return CGSize(width: view.frame.width, height: 55)
            }
        
        
       
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 100)
        }
        
      

           
    }

