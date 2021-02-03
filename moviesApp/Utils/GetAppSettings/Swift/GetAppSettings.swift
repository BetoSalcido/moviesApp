//
//  GetAppSettings.swift
//  moviesApp
//
//  Created by Beto Salcido on 01/02/21.
//

import Foundation

enum GetAppSettings {
    static func getValusFromAppConfig() -> AppConfig? {
        guard let path = Bundle.main.path(forResource: "AppConfig", ofType: "plist"), let plist = FileManager.default.contents(atPath: path) else {
            return nil
        }
        
        return try? PropertyListDecoder().decode(AppConfig.self, from: plist)
    }
}
