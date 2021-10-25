//
//  PlaylistElementView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI

struct PlaylistElementView: View {
    var playlist: Playlist
    
    var body: some View {
        HStack{
            Image(systemName: "forward.fill")
            Text(playlist.name)
            Spacer()
            Image(systemName: "forward.fill")
        }
    }
}

struct PlaylistElementView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistElementView(playlist: Playlist(name: "Playlist name"))
    }
}
