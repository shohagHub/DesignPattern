//
//  Singleton.swift
//  DesignPattern
//
//  Created by Saleh Enam Shohag on 9/3/20.
//  Copyright © 2020 Saleh Enam Shohag. All rights reserved.
//

import Foundation
///We can only create one object throughout the application
///i.e UIApplication
///

final public class AppSettings {
    //swift gurantees that static is thread safe
    public static let shared = AppSettings()
    private var settings: [String: Any] = ["Theme": "Dark", "maxConcurrentDownload": 4]

    private init() {}
    
    public func string(forKey key: String) -> String? {
        return settings[key] as? String
    }
    
    public func int(forKey key: String) ->  Int? {
        return settings[key] as? Int
    }
    
    public func set(value: Any, forKey key: String) {
         settings[key] = value
    }
    
}

///Reading data from multiple thread is safe
///but the situation changed when dictionary is updated and read from multiple thread.
///
//Soultion is serial Queue
///This solution will prevent the crash
///but this solution has performance issue.
///
final public class AppSettingsWithSearialQuuue {
    //swift gurantees that static is thread safe
    public static let shared = AppSettingsWithSearialQuuue()
    private var settings: [String: Any] = ["Theme": "Dark", "maxConcurrentDownload": 4]
    private let serialQueue = DispatchQueue(label: "serialQueue")

    private init() {}
    
    //we should also apply queue here so, that data is not retrived while data is write.
    public func string(forKey key: String) -> String? {
        var result: String?
        serialQueue.sync {
            result = settings[key] as? String
        }
        return result
    }
    
    public func int(forKey key: String) ->  Int? {
        var result: Int?
        serialQueue.sync {
            result = settings[key] as? Int
        }
        return result
    }
    
    public func set(value: Any, forKey key: String) {
        serialQueue.sync {
            settings[key] = value
        }
    }
    
}


///Solution of the performance issue.
///Reader's Writers lock
///
final public class AppSettingsPerformanceOptimise {
    //swift gurantees that static is thread safe
    public static let shared = AppSettingsPerformanceOptimise()
    private var settings: [String: Any] = ["Theme": "Dark", "maxConcurrentDownload": 4]
    private let concurrentQueue = DispatchQueue(label: "concurrent", attributes: .concurrent)

    private init() {}
    
    public func string(forKey key: String) -> String? {
        var result: String?
        concurrentQueue.sync {
            result = settings[key] as? String
        }
        return result
    }
    
    public func int(forKey key: String) ->  Int? {
        var result: Int?
        concurrentQueue.sync {
           result = settings[key] as? Int
        }
        return result
    }
    
    public func set(value: Any, forKey key: String) {
        concurrentQueue.async(flags: .barrier) {
            self.settings[key] = value
        }
    }
    
}

//update needs to be completed before any thread is allowed to access the dictionary
//barrier solve this problem.
