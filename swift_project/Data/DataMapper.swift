//
// Created by Jbara Omar on 14/12/2017.
// Copyright (c) 2017 Brogrammers. All rights reserved.
//
import Foundation

enum DataMapperError: Error {
    case errorReadingFile, elementNotFound
}

class DataMapper {
    
    static let instance = DataMapper()
    private let userDefaults = UserDefaults.standard
    private let FAVORITES_KEY_USER = "favorites_events"
    
    private init() {
    }
    
    var classifications: [Classification] {
        get {
            guard let filePath = Bundle.main.url(forResource: "classification", withExtension: "json") else { return [] }
            let data = try! Data(contentsOf: filePath)
            return try! JSONDecoder().decode([Classification].self, from: data)
        }
    }

    var friends: [Friend] {
        get {
            guard let filePath = Bundle.main.url(forResource: "friend", withExtension: "json") else { return [] }
            let data = try! Data(contentsOf: filePath)
            return try! JSONDecoder().decode([Friend].self, from: data)
        }
    }
}
