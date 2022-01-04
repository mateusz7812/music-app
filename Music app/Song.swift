//
//  Song.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import Foundation

struct Song: Identifiable{
    var id: Int?
    var name: String
    var author: String
    var duration: Int
    var path: String
    var albumId: Int?
    var album: Album?
}

extension Song{
    static var data: [Song]{
        [
            Song(id: 1, name: "Song1", author: "Author1", duration: Duration(hours: 0, minutes: 3, seconds: 30).toSeconds, path: "/song1.mp3"),
            Song(id: 2, name: "Song2", author: "Author2", duration: Duration(hours: 0, minutes: 2, seconds: 10).toSeconds, path: "/song2.mp3"),
            Song(id: 3, name: "Song3", author: "Author1", duration: Duration(hours: 0, minutes: 1, seconds: 20).toSeconds, path: "/song3.mp3")
        ]
    }
}

extension Song: Hashable{
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.id == rhs.id;
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
