//
//  ContentView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            NavigationLink(destination: PlaylistsView(playlists: Playlist.data)){
                SectionButtonView(text: "Playlists")
            }
            NavigationLink(destination: AlbumsView()){
                SectionButtonView(text: "Albums")
            }
            NavigationLink(destination: SongsView(songs: Song.data)){
                SectionButtonView(text: "Songs")
            }
            Spacer()
            Image(systemName: "forward.fill")
            Spacer()
            PlayerBarView()
        }
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.121)/*@END_MENU_TOKEN@*/)
        .navigationTitle("Menu")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ContentView()
        }
    }
}
