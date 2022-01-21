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
    @State var songs: [Song] = []
    @State private var songToDelete: Song?
    @Binding var dbCon: DBCon
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                    List{
                        ForEach(songs, id: \.name){ song in
                            Button(action: {}){
                                SongElementView(song: song)
                            }
                            .onTapGesture(){
                                player.set(song: song)
                                player.play()
                                player.set(songs: songs)
                            }
                            .onLongPressGesture(){
                                songToDelete = song
                            }
                            .accessibility(identifier: "\(song.name)_button")
                        }
                    }
                PlayerBarView(player: self.player)
            }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/)
            .navigationTitle("Songs")
            .toolbar {
                    Button("Add") {
                        showingSheet.toggle()
                    }
            }
            .alert(item: $songToDelete, content: { song in
                Alert(
                    title: Text("Deleting"),
                    message: Text("Do you want to delete \(song.name) - \(song.author)"),
                    primaryButton: .destructive(Text("Delete"), action: {
                        dbCon.removeSong(id: song.id!)
                        songs.remove(at: songs.firstIndex(of: song)!)
                    }),
                    secondaryButton: .cancel(Text("Cancel"))
                )
                
            })
            .onAppear(perform:{
                songs = dbCon.getSongs()
            })
            .navigationViewStyle(StackNavigationViewStyle())
            
            HalfASheet(isPresented: $showingSheet, title: "Add song"){
                VStack{
                    List{
                        Section{
                            FilePicker(path: $path)
                                .accessibility(identifier: "file_picker")
                            TextField("Title", text: $newSongTitle)
                                .accessibility(identifier: "title_field")
                            TextField("Author", text: $newSongAuthor)
                                .accessibility(identifier: "author_field")
                        }
                    }
                    .padding(.top, 10.0)
                    .listStyle(InsetGroupedListStyle())
                    Button("Add"){
                        if(self.path != "" && newSongTitle != "" && newSongAuthor != ""){
                            let audioAsset = AVURLAsset.init(url: URL(fileURLWithPath: self.path), options: nil)
                            let duration = audioAsset.duration
                            let durationInSeconds: Int = Int(CMTimeGetSeconds(duration))
                            
                            dbCon.addSong(song: Song(id: -1, name: newSongTitle, author: newSongAuthor, duration: durationInSeconds, path: self.path))
                            showingSheet.toggle()
                            newSongTitle = ""
                            newSongAuthor = ""
                            songs = dbCon.getSongs()
                        }
                    }
                    .accessibility(identifier: "add_song_button")
                }
            }
            .height(.fixed(250))
            .backgroundColor(UIColor.systemGroupedBackground)
        }
    }
}

struct SongsView_Previews: PreviewProvider {
    static var previews: some View {
        SongsView(player: Binding.constant(Player()), songs: Song.data, dbCon: Binding.constant(DBCon()))
    }
}
