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
            Image("sample")
                .resizable()
                .frame(width: 35, height: 35)
            VStack{
                Text(name)
                Text(author)
            }
            Spacer()
            Text(duration)
        }
    }
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        SongElementView(name: "Song name", author: "Song author", duration: "3:30")
    }
}
