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
    
    var filePath: URL {
        URL(fileURLWithPath: Bundle.main.path(forResource: self.rawValue, ofType: "wav") ?? "")
    }
    
}

final class SoundPlayer {
    private var audioPlayer: AVAudioPlayer!
    static let shared = SoundPlayer()
    
    func play(_ audio: Audio) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audio.filePath)
            audioPlayer?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func stop() {
        audioPlayer.stop()
    }
}
