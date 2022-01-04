//
//  AlbumElementView.swift
//  Music app
//
//  Created by stud on 08/11/2021.
//

import SwiftUI

struct AlbumElementView: View {
    var album: Album
    
    var body: some View {
        HStack{
            SavedImage.loadIfExists(imageName: album.artworkPath)
                .resizable()
                .frame(width: 35, height: 35)
            VStack(alignment: .leading){
                Text(album.name)
                Text(album.authors).font(.system(size: 10.0))
            }
            Spacer()
        }
    }
}

struct AlbumElementView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumElementView(album: Album(name: "Album 1", authors: "Author 1, Author 2"))
    }
}
