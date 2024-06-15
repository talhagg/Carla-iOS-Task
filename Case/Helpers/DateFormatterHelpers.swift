//
//  DateFormatterHelpers.swift
//  Case
//
//  Created by Talha Gölcügezli on 15.06.2024.
//

import Foundation

class DateFormatterHelper {
    static let shared = DateFormatterHelper()
    
    private let dateFormatter: DateFormatter
    
    private init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    func formatDate(_ dateString: String) -> String {
        guard let date = dateFormatter.date(from: dateString) else {
            return dateString
        }
        
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
}
