//
//  ContentView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI
import AVKit

struct ContentView: View {
    var dbCon: DBCon
    @Binding var player: Player
    var body: some View {
        VStack{
            List{
                NavigationLink(destination: PlaylistsView(player: self.$player, playlists: dbCon.getPlaylists())){
                    Text("Playlists")
                }
                NavigationLink(destination: AlbumsView(player: self.$player, albums: Album.data)){
                    Text("Albums")
                }
                NavigationLink(destination: SongsView(player: self.$player, songs: Song.data)){
                    Text("Songs")
                }
            }
            Image("sample")
                .resizable()
                .scaledToFit()
            PlayerBarView(player: self.player)
        }
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.105)/*@END_MENU_TOKEN@*/)
        .navigationTitle("Menu")
        .onAppear(perform: {
            //print("player: \(player!.isPlaying)")
            //dbCon.addPlaylist(playlist: Playlist.data[0])
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ContentView(dbCon: DBCon(), player: Binding.constant(Player()))
        }
    }
}
