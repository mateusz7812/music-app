//
//  Playlist.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import Foundation

struct Playlist: Identifiable {
    var id: Int?
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


extension Playlist: Hashable{
    static func == (lhs: Playlist, rhs: Playlist) -> Bool {
        return lhs.id == rhs.id;
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
