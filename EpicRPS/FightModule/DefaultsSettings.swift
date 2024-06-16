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
        case maleWinScore
        case femaleWinScore
        case maleLoseScore
        case femaleLooseScore
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
            userDefaults.integer(forKey: Keys.maleWinScore.rawValue)
        }
        
        set {
            userDefaults.setValue(newValue, forKey: Keys.maleWinScore.rawValue)
        }
    }
    
    static var maleLoosePlayerScore: Int? {
        get {
            userDefaults.integer(forKey: Keys.maleLoseScore.rawValue)
        }
        
        set {
            userDefaults.setValue(newValue, forKey: Keys.maleLoseScore.rawValue)
        }
    }
    
    static var femaleWinPlayerScore: Int? {
        get {
            userDefaults.integer(forKey: Keys.femaleWinScore.rawValue)
        }
        
        set {
            userDefaults.setValue(newValue, forKey: Keys.femaleWinScore.rawValue)
        }
    }
    
    static var femaleLoosePlayerScore: Int? {
        get {
            userDefaults.integer(forKey: Keys.femaleLooseScore.rawValue)
        }
        
        set {
            userDefaults.setValue(newValue, forKey: Keys.femaleLooseScore.rawValue)
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
