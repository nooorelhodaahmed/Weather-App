//
//  HeaderView.swift
//  WeatherApp
//
//  Created by user186640 on 11/28/20.
//

import UIKit


class WeatherHeader : UICollectionReusableView {
    
    
    //MARK:- Proporties
    
    
    
    var weather : WeatherModel? {
        didSet {
           configureUI()
        }
    }
   
    
    private var headerView : UIView = {
       
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
        
    }()
    
    private var WeatherImage : UIImageView = {
        
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
       
        imgView.setDimensions(width: 88, height: 92)
        return imgView
        
    }()
    
    private let tempratureLabel : UILabel = {
        
       let label = UILabel()
       
       label.font = UIFont.robotoRegular40
       label.textColor = UIColor.purplyBlue
       return label
    }()
    
   
    private let dateLabel : UILabel = {
        
       let label = UILabel()
      
       label.textColor = UIColor.purplyBlue
       label.font = UIFont.textStyle2
       return label
        
    }()
    
    private let spratorLine : UIImageView = {
       
        let imgView = UIImageView()
        imgView.image = #imageLiteral(resourceName: "Rectangle 413")
        imgView.contentMode = .scaleAspectFit
        
        return imgView
        
    }()
    
    private let highTempratureLable : UILabel = {
      
        let label = UILabel()
        label.font = UIFont.textStyle6
        label.textColor = UIColor.slate
        
        return label
    }()
    
    private let highTempratureImage: UIImageView = {
        
       let imgView = UIImageView()
        imgView.image = #imageLiteral(resourceName: "Path 5144")
        return imgView
        
    }()
    
    private let lowTempratureLable : UILabel = {
        let label = UILabel()
        label.font = UIFont.textStyle6
        label.textColor = UIColor.slate
        return label
    }()
    
    private let lowTempratureImage: UIImageView = {
        
       let imgView = UIImageView()
        imgView.image = #imageLiteral(resourceName: "Path 5543")
        return imgView
        
    }()
    
    private let weatherDetailsView : UIView = {
       
        let view = UIView()
        view.backgroundColor = .white
        view.setDimensions(width: 343, height: 120)
        return view
        
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
    
    func configureUI(){
        
        guard let weather = self.weather else {return}
         let viewModel = WeatherViewModel(weather: weather)

       
        
        addSubview(headerView)
        headerView.anchor(top: topAnchor,left:leftAnchor,right: rightAnchor,paddingTop: 141,paddingLeft: 16,paddingRight: 16)
        
        headerView.addSubview(WeatherImage)
       
        WeatherImage.centerY(inView: headerView)
        WeatherImage.anchor(left:leftAnchor,paddingLeft: 28.7)
        WeatherImage.loadImageUsingCache(withUrl: (EndPiont.imgUrl + (weather.weather_state_abbr ?? "") + ".png"))
        
        let stackView = UIStackView(arrangedSubviews:[tempratureLabel,dateLabel])
        headerView.addSubview(stackView)
        tempratureLabel.text = (String(viewModel.cityTemp ?? 0) + "C")
        dateLabel.text = String(viewModel.date)
        
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fillProportionally
        stackView.anchor(top: headerView.topAnchor,left:WeatherImage.rightAnchor,paddingTop: 43, paddingLeft: 30)
        
        headerView.addSubview(spratorLine)
        spratorLine.anchor(top:headerView.topAnchor,left: stackView.rightAnchor,paddingTop: 33,paddingLeft: 22.5)
        spratorLine.centerY(inView: headerView)
        spratorLine.setDimensions(width: 2, height: 100)
        
        let upStackView = UIStackView(arrangedSubviews: [highTempratureImage,highTempratureLable])
        upStackView.axis = .horizontal
        upStackView.spacing = 8.7
        upStackView.distribution = .fillEqually
        
        headerView.addSubview(upStackView)
        highTempratureLable.text = String(viewModel.highTemprature)
        
        upStackView.anchor(top:headerView.topAnchor,right: headerView.rightAnchor,paddingTop: 55.9,paddingRight: 26)
        
        let downStackView = UIStackView(arrangedSubviews: [lowTempratureImage,lowTempratureLable])
        downStackView.axis = .horizontal
        downStackView.spacing = 8.7
        downStackView.distribution = .fillEqually
       
        
        headerView.addSubview(downStackView)
        lowTempratureLable.text = String(viewModel.lowTemprature)
        downStackView.anchor(top: upStackView.bottomAnchor,right: headerView.rightAnchor,paddingTop: 15,paddingRight: 26)
        
        
        addSubview(weatherDetailsView)
        weatherDetailsView.anchor(top: downStackView.bottomAnchor, left: leftAnchor,right: rightAnchor,paddingTop: 80,paddingLeft: 16,paddingRight: 16)
        
        let detailedWeatherData1 = UIStackView(arrangedSubviews :[weatherDetailsView(withImg: #imageLiteral(resourceName: "Path 5541"), withTitle: "Rüzgar", withValue: (String(viewModel.windSpeed) + "mhs/s")) ,weatherDetailsView(withImg: #imageLiteral(resourceName: "Path 5555"), withTitle: "Nem", withValue: String(viewModel.humdity))])
        
        addSubview(detailedWeatherData1)
        detailedWeatherData1.anchor(top:weatherDetailsView.topAnchor,left: weatherDetailsView.leftAnchor,paddingTop: 17,paddingLeft: 19.6)
        detailedWeatherData1.spacing = 26
        detailedWeatherData1.axis = .vertical
        
        
        let detailedWeatherData2 = UIStackView(arrangedSubviews :[weatherDetailsView(withImg: #imageLiteral(resourceName: "Group 52"), withTitle: "Görünürlük", withValue: (String(viewModel.visiabilty) + "km"))])
        
        addSubview(detailedWeatherData2)
        detailedWeatherData2.anchor(top:weatherDetailsView.topAnchor,right: weatherDetailsView.rightAnchor,paddingTop: 17,paddingRight:  48)
        detailedWeatherData2.spacing = 26
        detailedWeatherData2.axis = .vertical
        
    }
    
  
         
           
    
    func weatherImgView(withImg  image: UIImage) -> UIView {
       
        let view = UIImageView()
        view.image = image
        view.backgroundColor = .white
        view.setDimensions(width: 55, height: 55)
        view.image = image
        view.contentMode = .scaleAspectFit
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
        
    }
    
    func weatherTimeView (withtime time: String)-> UILabel{
        let label = UILabel()
        label.textColor = .slate
        label.font = UIFont.textStyle9
        return label
        
    }
    
    func weatherDetailsView(withImg img:UIImage,withTitle title: String,withValue value:String) -> UIStackView {
        
        
        let  imgView = UIImageView()
        imgView.image = img
        imgView.contentMode = .scaleAspectFit
        
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.textStyle9
        titleLabel.textColor = UIColor.slate
        //titleLabel.numberOfLines = 0
        titleLabel.text = title
        
        let valueLabel = UILabel()
        valueLabel.font = UIFont.textStyle10
        valueLabel.textColor = .slate
        //valueLabel.numberOfLines = 0
        valueLabel.text = value
        
        let subStackView = UIStackView(arrangedSubviews: [titleLabel,valueLabel])
        subStackView.axis = .vertical
        subStackView.spacing = 2
        subStackView.distribution = .fillProportionally
       
        
        let stackView = UIStackView(arrangedSubviews: [imgView,subStackView])
        stackView.axis = .horizontal
        stackView.spacing = 2.6
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        
        
        return stackView
    }
    
    
   

    //MARK:- Selectors

}
