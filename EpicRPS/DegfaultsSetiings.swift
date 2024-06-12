//
//  DegfaultsSetiings.swift
//  EpicRPS
//
//  Created by Станислав Артамонов on 11.06.24.
//

import Foundation
struct DefaultsSettings {
    static private let userDefaults = UserDefaults.standard
    
    private enum Keys: String, CaseIterable {
        case roundTime
        case maxRoundCount
    }
    
    static var roundTime: Int? {
        get {
            userDefaults.integer(forKey: Keys.roundTime.rawValue)
        }
        
        set {
            userDefaults.setValue(newValue, forKey: Keys.roundTime.rawValue)
        }
    }
    
    static var maxRoundCount: Int? {
        get {
            userDefaults.integer(forKey: Keys.maxRoundCount.rawValue)
        }
        
        set {
            userDefaults.setValue(newValue, forKey: Keys.maxRoundCount.rawValue)
        }
    }
}
