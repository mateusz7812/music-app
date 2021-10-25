//
//  SongView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI

struct SongElementView: View {
    var name: String
    var author: String
    var duration: String

    var body: some View {
        HStack{
            Image(systemName: "forward.fill")
            VStack{
                Text(name)
                Text(author)
            }
            Spacer()
            Text(duration)
            Image(systemName: "forward.fill")
        }
    }
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        SongElementView(name: "Song name", author: "Song author", duration: "3:30")
    }
}
