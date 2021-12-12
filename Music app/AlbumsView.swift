//
//  AlbumsView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI
import AVKit

struct AlbumsView: View {
    @Binding var player: Player
    let albums: [Album]
    var body: some View {
        VStack{
            List{
                ForEach(albums, id: \.name){ album in
                    AlbumElementView(name: album.name, authors: album.authors)
                }
            }
            Spacer()
            PlayerBarView(player: self.player)
            
        }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/)
        .navigationTitle("Albums")
    }
}

struct AlbumsView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumsView(player: Binding.constant(Player()), albums: Album.data)
    }
}
