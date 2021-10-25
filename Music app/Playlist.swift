//
//  Playlist.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import Foundation

struct Playlist {
    var name: String
}

extension Playlist{
    static var data: [Playlist]{
        [
            Playlist(name: "Playlist 1"),
            Playlist(name: "Playlist 2"),
            Playlist(name: "Playlist 3")
        ]
    }
}
