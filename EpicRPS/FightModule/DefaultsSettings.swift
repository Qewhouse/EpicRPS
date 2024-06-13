//
//  DefaultsSettings.swift
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
        case pvpMode
        case maleScore
        case femaleScore
        
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
    
    static var pvpMode: Bool? {
        get {
            userDefaults.bool(forKey: Keys.pvpMode.rawValue)
        }
        
        set {
            userDefaults.setValue(newValue, forKey: Keys.pvpMode.rawValue)
        }
    }
    
    static var malePlayerScore: Int? {
        get {
            userDefaults.integer(forKey: Keys.maleScore.rawValue)
        }
        
        set {
            userDefaults.setValue(newValue, forKey: Keys.maleScore.rawValue)
        }
    }
    
    static var femalePlayerScore: Int? {
        get {
            userDefaults.integer(forKey: Keys.femaleScore.rawValue)
        }
        
        set {
            userDefaults.setValue(newValue, forKey: Keys.femaleScore.rawValue)
        }
    }
}
