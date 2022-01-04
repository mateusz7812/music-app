//
//  Player.swift
//  Music app
//
//  Created by Mac Mini on 12/12/2021.
//

import SwiftUI
import Foundation
import AVKit


class LastSongHolder{
    var lastHolder: LastSongHolder?
    var song: Song
    
    init(last_holder: LastSongHolder? = nil, last_song: Song) {
        lastHolder = last_holder
        song = last_song
    }
}

class Player: ObservableObject {
    var avPlayer: AVPlayer? = nil
    @Published var isPlaying: Bool = false
    @Published var currentTime: Float = 0
    @Published var duration: Float = 0
    @Published var currentSong: Song = Song(id: -1, name: "Shape of you", author: "Ed Sheeran", duration: Duration(hours: 0, minutes: 1, seconds: 2).toSeconds, path: Bundle.main.path(forResource: "sample4", ofType: "mp3")!)
    @Published var shuffling: Bool = false
    @Published var infinitePlaying: Bool = false
    var songs: [Song] = []
    var timeObserver: Any?
    var lastSongHolder: LastSongHolder? = nil

    init(){
        set(song: currentSong)
    }
    
    func set(song: Song){
        pause()
        lastSongHolder = LastSongHolder(last_holder: lastSongHolder, last_song: currentSong)
        currentSong = song
        avPlayer = AVPlayer(url: URL(fileURLWithPath: song.path))
        isPlaying = false
        
        let duration : CMTime = self.avPlayer!.currentItem!.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        self.duration = Float(seconds)
        
        self.timeObserver = avPlayer?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.avPlayer!.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds(self.avPlayer!.currentTime());
                self.currentTime = Float ( time )
            }
            if(self.duration - self.currentTime < 1){
                self.pause()
                self.autoSwitchToNextSong()
            }
        }
    }
    
    func set(songs: [Song]){
        self.songs = songs
    }
    
    func set(time: Float){
        self.avPlayer?.seek(to: CMTimeMake(value: Int64(time), timescale: 1))
    }
    
    func hasNextSong() -> Bool{
        if(infinitePlaying){
            return true
        }
        let curIndex = songs.firstIndex(of: currentSong)
        return !(curIndex == nil || songs.count == curIndex! + 1)
    }
    
    func getNextSong() -> Song{
        if(songs.isEmpty){
            return currentSong
        }
        if(shuffling){
            return songs[Int.random(in: 0..<songs.count)]
        }
        let curIndex = songs.firstIndex(of: currentSong)
        if(curIndex == nil || songs.count == curIndex! + 1){
            return songs[0]
        }
        return songs[curIndex! + 1]
    }
    
    func getLastSong() -> Song{
        let song = lastSongHolder?.song ?? currentSong
        lastSongHolder = lastSongHolder?.lastHolder
        return song
    }
    
    func autoSwitchToNextSong(){
        if(hasNextSong()){
            switchToNextSong()
        }
    }
    
    func switchToNextSong(){
        pause()
        avPlayer?.removeTimeObserver(timeObserver!)
        let nextSong = getNextSong()
        set(song: nextSong)
        play()
    }
    
    func switchToLastSong(){
        pause()
        avPlayer?.removeTimeObserver(timeObserver!)
        set(song: getLastSong())
        play()
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
