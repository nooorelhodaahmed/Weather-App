//
//  MainWeatherViewController.swift
//  WeatherApp
//
//  Created by user186640 on 11/27/20.
//

import UIKit

private  let headerIdentefier = "WeatherHeader"
private  let reuseIdentifier = "WeatherCell"

class WeatherController: UICollectionViewController {

    
   //MARK:- Proporties
    
   private let weekDayArray = ["pazartesi"  , "salı" ,"çarşamba" , "perşembe"  ,"cumā" ,"cumartesi" ,"pazar"]
   
    private var filteredArray = [WeatherModel]()
    
   private var weatherData = [WeatherModel]() {
        didSet{
            
            filteredArray = fetchFilteredWeather()
            collectionView.reloadData()
            
            
        }
    }
    
   //MARK:- LifeCycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredArray = fetchFilteredWeather()
        configureUI()
        
        configureCollectionView()
       
    }
    
      init(weatherData:[WeatherModel]){
        self.weatherData = weatherData
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.textStyle4 ,NSAttributedString.Key.foregroundColor: UIColor.slate]
        self.title = "Hava Durumu"
        
        
        let leftMenuItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(backAction))
        leftMenuItem.image = #imageLiteral(resourceName: "geri btn")
        
        self.navigationItem.setLeftBarButton(leftMenuItem, animated: false)
    }
    
   
    
    //MARK:- Helpers
    
    func configureUI(){
        
        view.backgroundColor = .white
       
    }
    
    
    
   
    func configureCollectionView(){
        collectionView.backgroundColor = .paleGrey
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(WeatherHeader.self
                                ,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentefier)

    }
    
    
    //MARK:- API
    
    func fetchFilteredWeather() -> [WeatherModel] {
        
        var filteredArray = [WeatherModel]()
        
        for   i in 0..<weatherData.count-1 {
            
            let date1 = weatherData[i].created?.substring(0..<10)
            let date2 = weatherData[i+1].created?.substring(0..<10)

            if date1 != date2 {
                filteredArray.append(weatherData[i])
                
            }
           
            
        }
        
        filteredArray.removeLast()
        return filteredArray
        
    }
   //MARK:- Selectors
    
    @objc func backAction() {
     
        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }
    
   
}
//MARK:- UICollectionViewDelegate
extension WeatherController {
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentefier, for: indexPath) as! WeatherHeader
        header.weather = weatherData[indexPath.row]
        return header
    }
    
}

//MARK:- UICollectionViewDataSource

extension WeatherController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weekDayArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WeatherCell
        
        
        
        cell.dayName.text = weekDayArray[indexPath.row]
        cell.weather = filteredArray[indexPath.row]
        return cell
    
  }
    
}

//MARK:- UICollectionViewDelegateFlowLayout

extension WeatherController: UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 500)
    }
    
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: view.frame.width, height: 53)
        }
    
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 32, bottom: 33, right: 32)
    }

}
