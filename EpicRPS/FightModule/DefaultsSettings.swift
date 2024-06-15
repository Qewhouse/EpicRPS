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
        case firstStart
        case roundTime
        case maxRoundCount
        case pvpMode
        case maleScore
        case femaleScore
        case darkMode
        case defaultFonMusic
    }
    
    static var isFirstStart: Bool? {
        get {
            userDefaults.bool(forKey: Keys.firstStart.rawValue)
        }
        
        set {
            userDefaults.setValue(newValue, forKey: Keys.firstStart.rawValue)
        }
    }
    
    static var darkMode: Bool? {
        get {
            userDefaults.bool(forKey: Keys.darkMode.rawValue)
        }
        
        set {
            userDefaults.setValue(newValue, forKey: Keys.darkMode.rawValue)
        }
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
    
    static var maleWinPlayerScore: Int? {
        get {
            userDefaults.integer(forKey: Keys.maleScore.rawValue)
        }
        
        set {
            userDefaults.setValue(newValue, forKey: Keys.maleScore.rawValue)
        }
    }
    
    static var maleLoosePlayerScore: Int? {
        get {
            userDefaults.integer(forKey: Keys.maleScore.rawValue)
        }
        
        set {
            userDefaults.setValue(newValue, forKey: Keys.maleScore.rawValue)
        }
    }
    
    static var femaleWinPlayerScore: Int? {
        get {
            userDefaults.integer(forKey: Keys.femaleScore.rawValue)
        }
        
        set {
            userDefaults.setValue(newValue, forKey: Keys.femaleScore.rawValue)
        }
    }
    
    static var femaleLoosePlayerScore: Int? {
        get {
            userDefaults.integer(forKey: Keys.femaleScore.rawValue)
        }
        
        set {
            userDefaults.setValue(newValue, forKey: Keys.femaleScore.rawValue)
        }
    }
    
    static var defaultFonMusicName: String? {
        get {
            userDefaults.string(forKey: Keys.defaultFonMusic.rawValue)
        }
        
        set {
            userDefaults.setValue(newValue, forKey: Keys.defaultFonMusic.rawValue)
        }
    }
}
