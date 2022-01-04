//
//  SongView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI

struct SongElementView: View {
    var song: Song

    var body: some View {
        HStack{
            SavedImage.loadIfExists(imageName: song.album?.artworkPath)
                .resizable()
                .frame(width: 35, height: 35)
            VStack(alignment: .leading){
                Text(song.name)
                    .font(.system(size: 14))
                Text(song.author)
                    .font(.system(size: 13))
            }
            Spacer()
            Text(Duration.from(song.duration).toString)
                .font(.system(size: 14))
        }
    }
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        SongElementView(song: Song.data[0])
    }
}
