//
//  DateFormatterHelpers.swift
//  Case
//
//  Created by Talha Gölcügezli on 15.06.2024.
//

import Foundation

class DateFormatterHelper {
    static let shared = DateFormatterHelper()
    
    private let inputDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private let outputDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.dd.MM"
        return formatter
    }()
    
    func formatDate(_ dateString: String) -> String {
        guard let date = inputDateFormatter.date(from: dateString) else {
            return dateString
        }
        
        return outputDateFormatter.string(from: date)
    }
}
