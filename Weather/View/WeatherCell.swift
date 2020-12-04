//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by user186640 on 11/28/20.
//

import UIKit


class WeatherCell : UICollectionViewCell {
    
    
    
    
    //MARK:-Proporties
    
    var weather : WeatherModel? {
        
        didSet {
            
            configure()
        }
    }
   
   
    
    
     var dayName : UILabel = {
       
        let label = UILabel()
        label.textColor = UIColor.slate
        label.font = UIFont.textStyle9
        return label
    
    }()
    
    var weatherImg: UIImageView = {
        
       let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.setDimensions(width: 24, height: 24)
        return imgView
        
    }()
    
    var highTempratureLabel : UILabel = {
        
        let label = UILabel()
        label.font = UIFont.textStyle8
        label.textColor = UIColor.slate
        label.setDimensions(width: 28, height: 17)
        return label
        
    }()
    
    
    var lowTempratureLabel : UILabel = {
        
        let label = UILabel()
        label.font = UIFont.textStyle11
        label.textColor = UIColor.blueGrey
        label.setDimensions(width: 28, height: 17)
        return label
        
    }()
    
    //MARK:-LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- Helpers
    
    func configureUI() {
        
        backgroundColor = .white
       
        
        addSubview(dayName)
        dayName.anchor(top :topAnchor,left:leftAnchor,paddingTop: 26,paddingLeft:  24)
        
        let stackView = UIStackView(arrangedSubviews: [weatherImg,highTempratureLabel,lowTempratureLabel])
        stackView.axis = .horizontal
        stackView.spacing = 18
        stackView.distribution = .fillProportionally
        
        addSubview(stackView)
        stackView.centerY(inView: self)
        stackView.anchor(right:rightAnchor,paddingRight: 30)
    
    }
    
    
    
    func configure(){
        
        guard var weather = self.weather else {return}
        let viewModel = WeatherViewModel(weather: weather)
        
        weatherImg.loadImageUsingCache(withUrl: (EndPiont.imgUrl + (viewModel.abbreviation) + ".png"))
        lowTempratureLabel.text = String(viewModel.lowTemprature ) + "C"
        highTempratureLabel.text = String(viewModel.highTemprature ) + "C"
        
        
    }
    
    
}
