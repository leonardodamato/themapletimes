//
//  String+Ext.swift
//  TheMapleTimes
//
//  Created by Leonardo D'Amato on 31/5/21.
//

import Foundation

extension String {
    var toDateString: String? {
        var date: Date?
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        date = formatter.date(from: self)
        
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "dd MMM yyyy  HH:mm"

        var result: String?
        if let date = date {
            result = dateStringFormatter.string(from: date)
        } else {
            return nil
            
        }

        return result
    }
}
