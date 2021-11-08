//
//  PlaylistsView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI

struct PlaylistsView: View {
    var playlists: [Playlist]
    var body: some View {
        VStack{
            List{
                ForEach(playlists, id: \.name){ playlist in
                    NavigationLink(destination: PlaylistView(songs: Song.data, name: "playlist1")){
                        PlaylistElementView(playlist: playlist)
                    }
                }
            }
            Spacer()
            PlayerBarView()
            
        }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/)
            .navigationTitle("Playlists")
    }
}

struct PlaylistsView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistsView(playlists: Playlist.data)
    }
}
