//
//  Song.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import Foundation

struct Song{
    var name: String
    var author: String
    var duration: Int
    var path: String
}

extension Song{
    static var data: [Song]{
        [
            Song(name: "Song1", author: "Author1", duration: Duration(hours: 0, minutes: 3, seconds: 30).toSeconds, path: "/song1.mp3"),
            Song(name: "Song2", author: "Author2", duration: Duration(hours: 0, minutes: 2, seconds: 10).toSeconds, path: "/song2.mp3"),
            Song(name: "Song3", author: "Author1", duration: Duration(hours: 0, minutes: 1, seconds: 20).toSeconds, path: "/song3.mp3")
        ]
    }
}
