//
//  Music_appTests.swift
//  Music appTests
//
//  Created by stud on 25/10/2021.
//

import XCTest

import AVKit

@testable import Music_app

class PlayerTester: Player{
    public var getAVPlayerWasCalled = false
    public var getAVPlayerSongPath = ""
    override func getAVPlayer(path: String) -> AVPlayer{
        getAVPlayerWasCalled = true
        getAVPlayerSongPath = path
        return super.getAVPlayer(path: path)
    }
}

extension LastSongHolder: Hashable {
    public static func == (lhs: LastSongHolder, rhs: LastSongHolder) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(song)
        hasher.combine(lastHolder)
    }
}

class Music_appTests: XCTestCase {
    private var player: PlayerTester? = nil
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        player = PlayerTester()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        player = nil
    }

    func testSetAVPlayerOnSongSet() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let song = DBCon().getSongs()[0]
        
        player!.set(song: song)
        
        XCTAssertEqual(player!.currentSong.hashValue, song.hashValue)
        XCTAssertTrue(player!.getAVPlayerWasCalled)
        XCTAssertEqual(song.path, player!.getAVPlayerSongPath)
    }
    
    func testPausePlayingOnSongSet(){
        let song = DBCon().getSongs()[0]
        player!.isPlaying = true
        
        player!.set(song: song)
        
        XCTAssertFalse(player!.isPlaying)
    }
    
    func testSaveLastSongOnSongSet(){
        let song = DBCon().getSongs()[0]
        let lastSongHolder = player!.lastSongHolder
        let last_song = player!.currentSong
        
        player!.set(song: song)
        
        let newLastSongHolder = player!.lastSongHolder
        XCTAssertEqual(lastSongHolder!.hashValue,  newLastSongHolder!.lastHolder!.hashValue)
        XCTAssertEqual(last_song.hashValue, newLastSongHolder!.song.hashValue)
    }

    func testGetNextSongWhenSongsEmpty(){
        player!.set(songs: [])
        let current_song = player!.currentSong
        
        let next_song = player!.getNextSong()

        XCTAssertEqual(current_song.hashValue, next_song.hashValue)
    }
    
    func testGetNextSongWhenSongsSingle(){
        let song = DBCon().getSongs()[0]
        player!.set(songs: [song])
        
        let next_song = player!.getNextSong()

        XCTAssertEqual(song.hashValue, next_song.hashValue)
    }
    
    func testGetLastSong(){
        let song = DBCon().getSongs()[0]
        let last_song = player!.currentSong
        player!.set(song: song)
        
        let last_song_result = player!.getLastSong()
        
        XCTAssertEqual(last_song.hashValue, last_song_result.hashValue)
    }

}
