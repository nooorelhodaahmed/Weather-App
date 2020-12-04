//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by user186640 on 11/28/20.
//

import UIKit



class CityCell: UICollectionViewCell {

    //MARK:- Proporties

    
    var city:CityModel? {
        
        didSet{
            configure()
        }
    }
   
    
    private let cityName : UILabel = {
        
        let label = UILabel()
        label.font = UIFont.textStyle8
        label.textColor = UIColor.systemBlue
        label.textAlignment = .center
        return label
    }()
    
    
    
    
    
    
    //MARK:- LifeCycle
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        backgroundColor = .white
        //self.contentView.isUserInteractionEnabled = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK:- Helpers
    
    func configureUI() {
       
        
       
        
        
      addSubview(cityName)
        
        cityName.centerX(inView: self)
        cityName.centerY(inView: self)
    
         
    }
    
    func configure(){
        
        guard let city = city else {return}
       
        let viewModel =  CityViewModel(city: city)
        cityName.text = viewModel.cityName
        
    }
    
   
    
    
    //MARK:- Selectors
    
    
   
    
}
    
    
