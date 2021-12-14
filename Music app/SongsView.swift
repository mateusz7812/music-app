//
//  SongsView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI
import AVKit
import HalfASheet

struct SongsView: View {
    @Binding var player: Player
    @State private var showingSheet = false;
    @State private var newSongTitle: String = "";
    @State private var newSongAuthor: String = "";
    @State private var path: String = "";
    var songs: [Song]
    
    var body: some View {
        ZStack{
            VStack{
                List{
                    ForEach(songs, id: \.name){ song in
                        SongElementView(name: song.name, author: song.author, duration: Duration.from(song.duration).toString)
                    }
                }
                Spacer()
                PlayerBarView(player: self.player)
            }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/)
            .navigationTitle("Songs")
            .toolbar {
                    Button("Add") {
                        showingSheet.toggle()
                    }
            }
            
            HalfASheet(isPresented: $showingSheet, title: "Add song"){
                VStack{
                    List{
                        Section{
                            FilePicker(path: $path)
                            TextField("Title", text: $newSongTitle)
                            TextField("Author", text: $newSongAuthor)
                        }
                    }
                    .padding(.top, 10.0)
                    .listStyle(InsetGroupedListStyle())
                    Button("Add"){
                        player.set(song: Song(name: newSongTitle, author: newSongAuthor, duration: Duration(hours: 0, minutes: 3, seconds: 0).toSeconds, path: self.path))
                        showingSheet.toggle()
                        newSongTitle = ""
                        newSongAuthor = ""
                    }
                }
            }
            .height(.proportional(0.55))
            .backgroundColor(UIColor.systemGroupedBackground)
        }
    }
}

struct SongsView_Previews: PreviewProvider {
    static var previews: some View {
        SongsView(player: Binding.constant(Player()), songs: Song.data)
    }
}
