//
//  AlbumElementView.swift
//  Music app
//
//  Created by stud on 08/11/2021.
//

import SwiftUI

struct AlbumElementView: View {
    var name: String
    var authors: [String]
    var body: some View {
        HStack{
            Image("sample")
                .resizable()
                .frame(width: 35, height: 35)
            VStack(alignment: .leading){
                Text(name)
                Text(authors.joined(separator: ", ")).font(.system(size: 10.0))
            }
            Spacer()
        }
    }
}

struct AlbumElementView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumElementView(name: "Album 1", authors: ["Author 1", "Author 2"])
    }
}
