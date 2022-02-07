//
//  Date+Ext.swift
//  CoppelApp
//
//  Created by Jose Cadena on 07/02/22.
//

import Foundation
extension String{
    func toDateString()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-DD"
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = "DD-MMM, YYYY"
        return dateFormatter.string(from: date)
    }
}
