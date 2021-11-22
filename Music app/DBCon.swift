//
//  DBCon.swift
//  Music app
//
//  Created by stud on 22/11/2021.
//

import Foundation
//import SQLite3
import SQLite



class DBCon {
    
    let playlistsTable = Table("playlists")
    let playlistName = Expression<String>("name")
    // piosenki jako pole a nie static
    // let playlistSongs = Expression<Song[]>("songs")  <- ??
    
    let songsTable = Table("songs")
    let songId = Expression<Int64>("id")
    let songName = Expression<String>("name")
    let songAuthor = Expression<String>("author")
    let songDuration = Expression<Duration>("duration")
    
    let albumsTable = Table("albums")
    let albumId = Expression<Int64>("id")
    let albumName = Expression<String>("name")
    // piosenki jako pole a nie static
    // let albumAuthors = Expression<Author[]>("authors")  <- ??
    // let albumSongs = Expression<Song[]>("songs")  <- ??
    
    
    
    func createTables() -> Void {
        
        do {
            let db = try Connection("path/to/db.sqlite3")

            try db.run(songsTable.create { t in
                t.column(songId, primaryKey: true)
                t.column(songName)
                t.column(songAuthor)
                //t.column(songDuration) nie dziala
            })
            
            try db.run(playlistsTable.create { t in
                t.column(playlistName, primaryKey: true)
                //t.column(playlistSongs)
            })
            
            try db.run(albumsTable.create { t in
                t.column(albumId, primaryKey: true)
                t.column(albumName)
                //t.column(albumAuthors)
                //t.column(albumSongs)
            })
            
        } catch {
            print (error)
        }
    }
    
    func deleteSong(id: Int) -> Int {
        
//   ??     let SongToDelete = songsTable.filter(songId == id)
        do {
            let db = try Connection("path/to/db.sqlite3")
            
            return try db.run(songtoDelete.delete())
        } catch {
            print("delete failed: \(error)")
        }
    }
    
//  analogicznie
//    func deletePlaylist(name: String) -> Int {
//
//    }
//
//    func deleteAlbum(id: Int) -> Int {
//
//    }
    
    
    func addPlaylist(playlist: Playlist) {
        do {
            let db = try Connection("path/to/db.sqlite3")
            let insert = playlistsTable.insert(playlistName <- "playlistName")
            let rowId = try db.run(insert)
        } catch {
            print("insert failed: \(error)")
        }
    }
    
    //analogicznie
    
    
}
