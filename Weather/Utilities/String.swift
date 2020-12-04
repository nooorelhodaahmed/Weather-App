//
//  String.swift
//  Weather
//
//  Created by user186640 on 12/3/20.
//

import Foundation

extension String {
    
    
    func substring(_ r: Range<Int>) -> String {
           let fromIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
           let toIndex = self.index(self.startIndex, offsetBy: r.upperBound)
           return self.substring(with: Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex)))
       }
    
    
    
    
}
