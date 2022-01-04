//
//  PlaylistView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI
import AVKit

struct PlaylistView: View {
    @Binding var dbCon: DBCon
    @State var editMode: EditMode = .inactive
    @Binding var player: Player
    @State var playlistSongs: [Song] = []
    @State var allSongs: [Song] = []
    var playlist: Playlist
    
    fileprivate func handleSongTap(_ song: Song) {
        if(editMode.isEditing){
            if(playlistSongs.contains(song)){
                dbCon.removeSongFromPlaylist(playlist_id: playlist.id!, song_id: song.id!)
                playlistSongs.remove(at: playlistSongs.firstIndex(of: song)!)
            } else {
                dbCon.addSongToPlaylist(playlist_id: playlist.id!, song_id: song.id!)
                playlistSongs.append(song)
            }
        } else {
            player.set(song: song)
            player.play()
            player.set(songs: playlistSongs)
        }
    }
    
    var body: some View {
        VStack{
            TabView{
                List{
                    ForEach(allSongs, id: \.id){ song in
                        if(playlistSongs.contains(song) || editMode.isEditing){
                            HStack{
                                SongElementView(song: song)
                                if(editMode.isEditing){
                                    Image(systemName: (playlistSongs.contains(song) ? "plus.circle.fill" : "plus.circle"))
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
            }
            .tabViewStyle(PageTabViewStyle())
            Spacer()
            PlayerBarView(player: self.player)
        }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/)
        .navigationTitle(playlist.name)
        .toolbar {
            EditButton()
        }
        .environment(\.editMode, $editMode)
        .onAppear(perform: {
            allSongs = dbCon.getSongs()
            playlistSongs = dbCon.getPlaylistSongs(playlist_id: playlist.id!)
        })
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView(dbCon: Binding.constant(DBCon()), player: Binding.constant(Player()), playlist: Playlist.data[0])
    }
}
