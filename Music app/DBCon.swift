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
    let playlistId = Expression<Int64>("id")
    let playlistName = Expression<String>("name")
    
    let songsTable = Table("songs")
    let songId = Expression<Int64>("id")
    let songName = Expression<String>("name")
    let songAuthor = Expression<String>("author")
    let songDuration = Expression<Duration>("duration")
    let songAlbumId = Expression<Int64>("albumId")
    
    let playlistSongsTable = Table("playlists_songs")
    let psId = Expression<Int64>("id")
    let psSongId = Expression<Int64>("song_id")
    let psPlaylistId = Expression<Int64>("playlist_id")
    
    let albumsTable = Table("albums")
    let albumId = Expression<Int64>("id")
    let albumName = Expression<String>("name")
    let authorsName = Expression<String>("authors")
    
    func getConnection() throws -> Connection {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        print("path: \(path)/db.sqlite3")

        return try Connection("\(path)/db.sqlite3")
    }
    
    func createTables() -> Void {
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let destinationPath = documents + "/db.sqlite3"
        let exists = FileManager.default.fileExists(atPath: destinationPath)
        guard !exists else
        {
            print("db already exist")
            return
        }
        do {
            let db = try getConnection()

            try db.run(songsTable.create { t in
                t.column(songId, primaryKey: true)
                t.column(songName)
                t.column(songAuthor)
                t.column(songDuration)
                t.column(songAlbumId, references: albumsTable, albumId)
            })
            
            try db.run(playlistsTable.create { t in
                t.column(playlistId, primaryKey: true)
                t.column(playlistName)
            })
            
            try db.run(playlistSongsTable.create { t in
                t.column(psId, primaryKey: true)
                t.column(psSongId, references: songsTable, songId)
                t.column(psPlaylistId, references: playlistsTable, playlistId)
            })
            
            try db.run(albumsTable.create { t in
                t.column(albumId, primaryKey: true)
                t.column(albumName)
            })
            
        } catch {
            print ("!!!!!!!!!!!!!!!!!!\ncatched")
            print (error)
        }
    }
    
//    func deleteSong(id: Int) -> Int {
        
//   ??     let SongToDelete = songsTable.filter(songId == id)
//        do {
//            let db = try Connection("path/to/db.sqlite3")
//
//            return try db.run(songtoDelete.delete())
//        } catch {
//            print("delete failed: \(error)")
//        }
//    }
    
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
            let db = try getConnection()
            let insert = playlistsTable.insert(playlistName <- playlist.name)
            /*let rowId = */try db.run(insert)
            //print("id: \(rowId)")
            //let playlist = playlistsTable.filter(playlistId == rowId)
            //for x in try db.prepare(playlist.select(playlistName)){
            //    print("test: \(try x.get(playlistName))")
            //}
            //for p in try db.prepare(playlistsTable){
            //    print("id: \(try p.get(playlistId))name: \(try p.get(playlistName))")
            //}
        } catch {
            print("insert failed: \(error)")
        }
    }
    
    func getPlaylists() -> [Playlist]{
        do {
            var playlists: [Playlist] = []
            let db = try getConnection()
            for p in try db.prepare(playlistsTable){
                playlists.append(Playlist(id: Int(truncatingIfNeeded: try p.get(playlistId)), name: try p.get(playlistName)))
            }
            return playlists
        } catch {
            print("getPlaylistsError")
            return []
        }
    }
    
    func addAlbum(album: Album){
        do {
            let db = try getConnection()
            let insert = albumsTable.insert(albumName <- album.name)
            try db.run(insert)
        } catch {
            print("insert failed: \(error)")
        }
    }
    
    func getAlbums() -> [Album]{
        do {
            var albums: [Album] = []
            let db = try getConnection()
            for p in try db.prepare(albumsTable){
                albums.append(Album(id: Int(truncatingIfNeeded: try p.get(albumId)), name: try p.get(albumName), authors: try p.get(authorsName)))
            }
            return albums
        } catch {
            print("getAlbumsError")
            return []
        }
    }
}
