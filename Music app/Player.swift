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
    var avPlayer: AVPlayer? = nil
    @Published var isPlaying: Bool = false
    @Published var currentTime: Float = 0
    @Published var duration: Float = 0
    @Published var currentSong: Song = Song(name: "Shape of you", author: "Ed Sheeran", duration: Duration(hours: 0, minutes: 1, seconds: 2).toSeconds, path: Bundle.main.path(forResource: "sample4", ofType: "mp3")!)
    
    init(){
        set(song: currentSong)
    }
    
    func set(song: Song){
        currentSong = song
        avPlayer = AVPlayer(url: URL(fileURLWithPath: song.path))
        isPlaying = false
        
        let duration : CMTime = self.avPlayer!.currentItem!.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        self.duration = Float(seconds)
        
        avPlayer?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.avPlayer!.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds(self.avPlayer!.currentTime());
                self.currentTime = Float ( time )
            }
        }
    }
    
    func set(time: Float){
        self.avPlayer?.seek(to: CMTimeMake(value: Int64(time), timescale: 1))
    }
    
    func play(){
        avPlayer?.play()
        isPlaying = true
    }
    
    func pause(){
        avPlayer?.pause()
        isPlaying = false
    }
}
