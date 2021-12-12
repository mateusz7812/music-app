//
//  PlaylistView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI
import AVKit

struct PlaylistView: View {
    @Binding var player: Player
    var songs: [Song]
    var name: String
    var body: some View {
        VStack{
            List{
                ForEach(songs, id: \.name){ song in
                    SongElementView(name: song.name, author: song.author, duration: song.duration.to_String())
                }
            }
            Spacer()
            PlayerBarView(player: self.player)
        }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/)
        .navigationTitle(name)
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView(player: Binding.constant(Player()), songs: Song.data, name: "Playlist 1")
    }
}
