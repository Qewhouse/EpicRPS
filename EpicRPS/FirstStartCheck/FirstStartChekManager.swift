//
//  FirstStartChekManager.swift
//  EpicRPS
//
//  Created by Станислав Артамонов on 15.06.24.
//

import Foundation

final class FirstStartChekService: NSObject {
    func startChekAndConfigureDefaults() {
        if DefaultsSettings.isFirstStart == nil {
            DefaultsSettings.femaleWinPlayerScore = 0
            DefaultsSettings.femaleLoosePlayerScore = 0
            DefaultsSettings.maleWinPlayerScore = 0
            DefaultsSettings.maleLoosePlayerScore = 0
            DefaultsSettings.maxRoundCount = 3
            DefaultsSettings.pvpMode = false
            DefaultsSettings.roundTime = 30
            DefaultsSettings.darkMode = false 
            DefaultsSettings.defaultFonMusicName = "Мелодия1"
            DefaultsSettings.isFirstStart = true
        }
    }
}
