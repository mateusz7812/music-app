//
//  AlbumsView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI

struct AlbumsView: View {
    let albums: [Album]
    var body: some View {
        VStack{
            List{
                ForEach(albums, id: \.name){ album in
                    AlbumElementView(name: album.name, authors: album.authors)
                }
            }
            Spacer()
            PlayerBarView()
            
        }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/)
        .navigationTitle("Albums")
    }
}

struct AlbumsView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumsView(albums: Album.data)
    }
}
