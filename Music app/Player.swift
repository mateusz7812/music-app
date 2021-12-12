//
//  Player.swift
//  Music app
//
//  Created by Mac Mini on 12/12/2021.
//

import SwiftUI
import Foundation
import AVKit

class Player: ObservableObject {
    var avPlayer: AVAudioPlayer = AVAudioPlayer()
    @Published var isPlaying: Bool = false
    @Published var sliderValue: Float = 0.0
    
    init(){
        let sound = Bundle.main.path(forResource: "sample4", ofType: "mp3")
        self.avPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
    }
    
    func play(){
        print(avPlayer.url)
        avPlayer.prepareToPlay()
        avPlayer.play()
        isPlaying = true
    }
    
    func pause(){
        avPlayer.pause()
        isPlaying = false
    }
}
