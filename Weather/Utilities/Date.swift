//
//  Date.swift
//  Weather
//
//  Created by user186640 on 12/3/20.
//

import Foundation


extension Date {

 static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy/MM/dd"

        return dateFormatter.string(from: Date())

    }
}
