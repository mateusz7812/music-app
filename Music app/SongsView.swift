//
//  SongsView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI

struct SongsView: View {
    var songs: [Song]
    var body: some View {
        VStack{
            List{
                ForEach(songs, id: \.name){ song in
                    SongElementView(name: song.name, author: song.author, duration: song.duration.to_String())
                }
            }
            Spacer()
            PlayerBarView()
        }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/)
        .navigationTitle("Songs")
    }
}

struct SongsView_Previews: PreviewProvider {
    static var previews: some View {
        SongsView(songs: Song.data)
    }
}
