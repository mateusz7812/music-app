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
    let songDuration = Expression<Int64>("duration")
    let songPath = Expression<String>("path")
    let songAlbumId = Expression<Int64?>("albumId")
    
    let playlistSongsTable = Table("playlists_songs")
    let psId = Expression<Int64>("id")
    let psSongId = Expression<Int64>("song_id")
    let psPlaylistId = Expression<Int64>("playlist_id")
    
    let albumsTable = Table("albums")
    let albumId = Expression<Int64>("id")
    let albumName = Expression<String>("name")
    let albumAuthors = Expression<String>("authors")
    let albumArtworkPath = Expression<String?>("artwork_path")
    
    func getConnection() throws -> Connection {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!

        return try Connection("\(path)/db.sqlite3")
    }
    
    func createTables() -> Void {
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let destinationPath = documents + "/db.sqlite3"
        let exists = FileManager.default.fileExists(atPath: destinationPath)
        
        print("path: \(destinationPath)")
        guard !exists else
        {
            print("db already exist")
            return
        }
        do {
            let db = try getConnection()

            try db.run(songsTable.create { t in
                t.column(songId, primaryKey: .autoincrement)
                t.column(songName)
                t.column(songAuthor)
                t.column(songDuration)
                t.column(songPath)
                t.column(songAlbumId, references: albumsTable, albumId)
            })
            
            try db.run(playlistsTable.create { t in
                t.column(playlistId, primaryKey: .autoincrement)
                t.column(playlistName)
            })
            
            try db.run(playlistSongsTable.create { t in
                t.column(psId, primaryKey: .autoincrement)
                t.column(psSongId, references: songsTable, songId)
                t.column(psPlaylistId, references: playlistsTable, playlistId)
            })
            
            try db.run(albumsTable.create { t in
                t.column(albumId, primaryKey: .autoincrement)
                t.column(albumName)
                t.column(albumAuthors)
                t.column(albumArtworkPath)
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
    
    func removePlaylist(id: Int){
        do {
            let db = try getConnection()
            let removePlaylistSongs = playlistSongsTable.filter(psPlaylistId == Int64(id)).delete()
            try db.run(removePlaylistSongs)
            let removePlaylist = playlistsTable.filter(playlistId == Int64(id)).delete()
            try db.run(removePlaylist)
        } catch {
            print("delete failed: \(error)")
        }
    }
    
    func getPlaylistSongs(playlist_id: Int) -> [Song]{
        do {
            var songs: [Song] = []
            let db = try getConnection()
            let query = playlistSongsTable
                .filter(playlistSongsTable[psPlaylistId] == Int64(playlist_id))
                .join(.inner, songsTable, on: songsTable[songId] == playlistSongsTable[psSongId])
            for p in try db.prepare(query){
                songs.append(Song(id: Int(truncatingIfNeeded: try p.get(songsTable[songId])), name: try p.get(songName), author: try p.get(songAuthor), duration: Int(truncatingIfNeeded: try p.get(songDuration)), path: try p.get(songPath)))
            }
            return songs
        } catch {
            print("getPlaylistSongsError: \(error)")
            return []
        }
    }
    
    func addSongToPlaylist(playlist_id: Int, song_id: Int){
        do {
            let db = try getConnection()
            let insert = playlistSongsTable.insert(psSongId <- Int64(song_id), psPlaylistId <- Int64(playlist_id))
            try db.run(insert)
        } catch {
            print("insert failed: \(error)")
        }
    }
    
    func removeSongFromPlaylist(playlist_id: Int, song_id: Int){
        do {
            let db = try getConnection()
            let remove = playlistSongsTable.filter(psSongId == Int64(song_id) && psPlaylistId == Int64(playlist_id)).delete()
            try db.run(remove)
        } catch {
            print("delete failed: \(error)")
        }
    }
    
    func addAlbum(album: Album) -> Int?{
        do {
            let db = try getConnection()
            let insert = albumsTable.insert(albumName <- album.name, albumAuthors <- album.authors, albumArtworkPath <- album.artworkPath)
            let albumId = try db.run(insert)
            return Int(truncatingIfNeeded: albumId)
        } catch {
            print("insert failed: \(error)")
        }
        return nil
    }
    
    func getAlbums() -> [Album]{
        do {
            var albums: [Album] = []
            let db = try getConnection()
            for p in try db.prepare(albumsTable){
                albums.append(Album(id: Int(truncatingIfNeeded: try p.get(albumId)), name: try p.get(albumName), authors: try p.get(albumAuthors), artworkPath: try p.get(albumArtworkPath)))
            }
            return albums
        } catch {
            print("getAlbumsError, \(error)")
            return []
        }
    }
    
    func addSongToAlbum(album_id: Int, song_id: Int){
        do {
            let db = try getConnection()
            let update = songsTable.filter(songId == Int64(song_id)).update(songAlbumId <- Int64(album_id))
            try db.run(update)
        } catch {
            print("update failed: \(error)")
        }
    }
    
    func removeSongFromAlbum(song_id: Int){
        do {
            let db = try getConnection()
            let update = songsTable.filter(songId == Int64(song_id)).update(songAlbumId <- nil)
            try db.run(update)
        } catch {
            print("delete failed: \(error)")
        }
    }
    
    func getSongsWithoutAlbum() -> [Song]{
        do {
            var songs: [Song] = []
            let db = try getConnection()
            let filter = songsTable.filter(songAlbumId == nil)
            for p in try db.prepare(filter){
                songs.append(Song(id: Int(truncatingIfNeeded: try p.get(songId)), name: try p.get(songName), author: try p.get(songAuthor), duration: Int(truncatingIfNeeded: try p.get(songDuration)), path: try p.get(songPath)))
            }
            return songs
        } catch {
            print("getSongsError")
            return []
        }
    }
    
    func getAlbumSongs(album_id: Int) -> [Song]{
        do {
            var songs: [Song] = []
            let db = try getConnection()
            let query = songsTable.where(songAlbumId == Int64(album_id))
            for p in try db.prepare(query){
                let albumIdRaw = try p.get(songAlbumId)
                var albumId: Int?
                if (albumIdRaw != nil){
                    albumId = Int(truncatingIfNeeded: albumIdRaw!)
                }
                songs.append(Song(id: Int(truncatingIfNeeded: try p.get(songId)), name: try p.get(songName), author: try p.get(songAuthor), duration: Int(truncatingIfNeeded: try p.get(songDuration)), path: try p.get(songPath), albumId: albumId))
            }
            return songs
        } catch {
            print("getAlbumSongsError: \(error)")
            return []
        }
    }
    
    func removeAlbum(id: Int){
        do {
            let db = try getConnection()
            let updateSongs = songsTable.filter(songAlbumId == Int64(id)).update(songAlbumId <- nil)
            try db.run(updateSongs)
            let remove = albumsTable.filter(albumId == Int64(id)).delete()
            try db.run(remove)
        } catch {
            print("delete failed: \(error)")
        }
    }
    
    func addArtworkToAlbum(album_id: Int, artwork_path: String){
        do {
            let db = try getConnection()
            let album = albumsTable.filter(albumId == Int64(album_id))
            if try db.run(album.update(albumArtworkPath <- artwork_path)) > 0 {
                print("updated album")
            } else {
                print("album not found")
            }
        } catch {
            print("update failed: \(error)")
        }
    }
    
    func addSong(song: Song){
        do {
            let db = try getConnection()
            let insert = songsTable.insert(songName <- song.name, songAuthor <- song.author, songDuration <- Int64(song.duration), songPath <- song.path)
            try db.run(insert)
        } catch {
            print("insert failed: \(error)")
        }
    }
    
    func getSongs() -> [Song]{
        do {
            var songs: [Song] = []
            let db = try getConnection()
            for p in try db.prepare(songsTable.join(.leftOuter, albumsTable, on: songsTable[songAlbumId] == albumsTable[albumId])){
                let albumIdRaw = try p.get(songAlbumId)
                var albumId: Int?
                var album: Album?
                if (albumIdRaw != nil){
                    albumId = Int(truncatingIfNeeded: albumIdRaw!)
                    album = Album(id: albumId, name: try p.get(albumsTable[albumName]), authors: try p.get(albumAuthors), artworkPath: try p.get(albumArtworkPath))
                }
                songs.append(Song(id: Int(truncatingIfNeeded: try p.get(songsTable[songId])), name: try p.get(songsTable[songName]), author: try p.get(songAuthor), duration: Int(truncatingIfNeeded: try p.get(songDuration)), path: try p.get(songPath), albumId: albumId, album: album))
            }
            return songs
        } catch {
            print("getSongsError \(error)")
            return []
        }
    }
    
    func removeSong(id: Int){
        do {
            let db = try getConnection()
            let remove = songsTable.filter(songId == Int64(id)).delete()
            try db.run(remove)
        } catch {
            print("delete failed: \(error)")
        }
    }
    
}
