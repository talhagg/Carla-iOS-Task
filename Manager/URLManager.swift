//
//  URLManager.swift
//  CaseService
//
//  Created by Talha Gölcügezli on 14.06.2024.
//

import Foundation

enum RoversURL: String {
    case baseURL = "RoversBaseURL"
    case latest = "latets"
}

public final class URLManager {
    static let shared = URLManager()
    private let plistName = "URLs"
    private var plistDict: [String: Any]?
    
    private init() {
        loadPlistData()
    }
    
    private func loadPlistData() {
        guard let plistURL = Bundle.main.url(forResource: plistName, withExtension: "plist") else {
            fatalError("\(plistName).plist not found")
        }
        
        guard let plistData = try? Data(contentsOf: plistURL),
              let plistDict = try? PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [String: Any] else {
            fatalError("Failed to load \(plistName).plist")
        }
        
        self.plistDict = plistDict
    }
    
    func getURL(for key: RoversURL) -> String? {
        return plistDict?[key.rawValue] as? String
    }
}
