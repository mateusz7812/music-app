//
//  AlbumSongsView.swift
//  Music app
//
//  Created by Mac Mini on 03/01/2022.
//

import SwiftUI

struct AlbumSongsView: View {
    @Binding var dbCon: DBCon
    @State var editMode: EditMode = .inactive
    @Binding var player: Player
    @State var albumSongs: [Song] = []
    @State var allSongs: [Song] = []
    var album: Album
    
    fileprivate func handleSongTap(_ song: Song) {
        if(editMode.isEditing){
            if(albumSongs.contains(song)){
                dbCon.removeSongFromAlbum(song_id: song.id!)
                albumSongs.remove(at: albumSongs.firstIndex(of: song)!)
            } else {
                dbCon.addSongToAlbum(album_id: album.id!, song_id: song.id!)
                albumSongs.append(allSongs[allSongs.firstIndex(of: song)!])
            }
            print("album songs count: \(albumSongs.count)")
        } else {
            player.set(song: song)
            player.play()
            player.set(songs: albumSongs)
        }
    }
    
    var body: some View {
        VStack{
            List{
                ForEach(allSongs, id: \.id){ song in
                    if(albumSongs.contains(song) || (!albumSongs.contains(song) && editMode.isEditing && (song.albumId == nil || song.albumId == album.id!))){
                        HStack{
                            SongElementView(song: song)
                            if(editMode.isEditing){
                                Image(systemName: (albumSongs.contains(song) ? "plus.circle.fill" : "plus.circle"))
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: Alignment.center)
                                    .foregroundColor(.blue)
                            }
                        }
                        .onTapGesture {
                            handleSongTap(song)
                        }
                    }
                }
            }
            Spacer()
            PlayerBarView(player: self.player)
        }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/)
        .navigationTitle(album.name)
        .toolbar {
            EditButton()
        }
        .environment(\.editMode, $editMode)
        .onAppear(perform: {
            allSongs = dbCon.getSongs()
            albumSongs = dbCon.getAlbumSongs(album_id: album.id!)
        })
    }
}

struct AlbumSongsView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumSongsView(dbCon: Binding.constant(DBCon()), player: Binding.constant(Player()), album: Album.data[0])
    }
}
