//
//  PlaylistsView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI
import HalfASheet

struct PlaylistsView: View {
    @Binding var player: Player
    @State private var showingSheet = false;
    @State private var playlistName = "";
    @State var playlists: [Playlist]
    var body: some View {
        ZStack{
        VStack{
            List{
                ForEach(playlists, id: \.name){ playlist in
                    NavigationLink(destination: PlaylistView(player: self.$player, songs: Song.data, name: playlist.name)){
                        PlaylistElementView(playlist: playlist)
                    }
                }
            }
            Spacer()
            PlayerBarView(player: self.player)
        }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/)
        .navigationTitle("Playlists")
        .toolbar {
                Button("New") {
                    showingSheet.toggle()
                }
        }
        HalfASheet(isPresented: $showingSheet, title: "New playlist"){
            VStack{
                List{
                    Section{
                        TextField("Name", text: $playlistName)
                    }
                }
                .padding(.top, 10.0)
                .listStyle(InsetGroupedListStyle())
                Button("Add"){
                    print("playlist \(playlistName) adding")
                    DBCon().addPlaylist(playlist: Playlist(name:playlistName))
                    playlists = DBCon().getPlaylists()
                    showingSheet.toggle()
                }
                Spacer()
            }
        }
        .height(.proportional(0.35))
        .backgroundColor(UIColor.systemGroupedBackground)
        }
    }
}

struct PlaylistsView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistsView(player: Binding.constant(Player()), playlists: Playlist.data)
    }
}
