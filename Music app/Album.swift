//
//  Album.swift
//  Music app
//
//  Created by stud on 08/11/2021.
//

import Foundation

struct Album: Identifiable{
    var id: Int?
    var name: String
    var authors: String
    var artworkPath: String?
}

extension Album{
    static var data: [Album]{
        [
            Album(name: "Album 1", authors: "Author 1, Author 2"),
            Album(name: "Album 2", authors: "Author 3, Author 2"),
            Album(name: "Album 3", authors: "Author 1, Author 4")
        ]
    }
}

extension Album: Hashable{
    static func == (lhs: Album, rhs: Album) -> Bool {
        return lhs.id == rhs.id;
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
