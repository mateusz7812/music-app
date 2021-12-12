//
//  Album.swift
//  Music app
//
//  Created by stud on 08/11/2021.
//

import Foundation

struct Album{
    var id: Int?
    var name: String
    var authors: String
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
