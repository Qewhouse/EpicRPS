//
//  SoundPlayer.swift
//  EpicRPS
//
//  Created by Андрей Линьков on 15.06.2024.
//
import Foundation
import AVFoundation

enum Audio: String {
    case handSelection = "handSelection"
    case handStrike = "handStrike"
    case winApplause = "winApplause"
    case fonMusic1 = "Мелодия1"
    case fonMusic2 = "Мелодия2"
    case fonMusic3 = "Мелодия3"
    case youLost = "youLost"

    
    var filePath: URL {
        URL(fileURLWithPath: Bundle.main.path(forResource: self.rawValue, ofType: "wav") ?? "")
    }
    
}

final class SoundPlayer {
    private var audioPlayer: AVAudioPlayer!
    private var backgroundPlayer: AVAudioPlayer!
    static let shared = SoundPlayer()
    
    func play(_ audio: Audio) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audio.filePath)
            audioPlayer.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func playBackground(_ audio: Audio) {
        do {
            backgroundPlayer = try AVAudioPlayer(contentsOf: audio.filePath)
            backgroundPlayer.numberOfLoops = -1
            backgroundPlayer.prepareToPlay()
            backgroundPlayer?.play()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func stop() {
        audioPlayer.stop()
        backgroundPlayer.stop()
    }
}
 
