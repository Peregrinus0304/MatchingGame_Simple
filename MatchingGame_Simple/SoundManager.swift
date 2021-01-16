//
//  SoundManager.swift
//  MatchingGame_Simple
//
//  Created by Ozzy on 16.01.2021.
//  Copyright © 2021 Taras Motruk. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    static var audioPlayer:AVAudioPlayer?
    
    enum SoundEffect {
        case flip
        case start
        case match
        case nomatch
        case win
        case lose
    }
    
    static func playSound(_ effect:SoundEffect) {
        
        var soundFilename = " "
        
        // switching the soundfile names
        switch effect {
            case .flip:
                soundFilename = "flipsound"
            case .start:
                soundFilename = "startsound"
            case .match:
                soundFilename = "matchsound"
            case .nomatch:
                soundFilename = "nomatchsound"
            case .win:
                soundFilename = "winsound"
            case .lose:
                soundFilename = "losesound"
        }
        
        // create path for wav files
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
        guard bundlePath != nil else {
            print("Couldn`t find sound file \(soundFilename) in the bundle")
            return
        }
        
        // create soundURL
        let soundURL = URL(fileURLWithPath: bundlePath!)
        
        // play the sound
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        }
        catch {
            print("Couldn`t create the audio player object for sound file \(soundFilename)")
        }
        
    }
    
}
