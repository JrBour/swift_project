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
    
//    var categories: [Category] {
//        get {
//            guard let filePath = Bundle.main.url(forResource: "categories", withExtension: "json") else {
//                return []
//            }
//            let data = try! Data(contentsOf: filePath)
//            return try! JSONDecoder().decode([Category].self, from: data)
//        }
//    }
//
//    var places: [Place] {
//        get {
//            guard let filePath = Bundle.main.url(forResource: "places", withExtension: "json") else {
//                return []
//            }
//            let data = try! Data(contentsOf: filePath)
//            return try! JSONDecoder().decode([Place].self, from: data)
//        }
//    }
}
