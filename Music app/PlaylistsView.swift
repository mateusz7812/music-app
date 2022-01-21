//
//  PlaylistsView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI
import HalfASheet

struct PlaylistsView: View {
    @Binding var dbCon: DBCon
    @Binding var player: Player
    @State private var showingSheet = false;
    @State private var playlistName = "";
    @State var playlists: [Playlist] = []
    @State private var playlistToDelete: Playlist?
    
    var body: some View {
        ZStack{
        VStack(spacing: 0){
                List{
                    ForEach(playlists, id: \.name){ playlist in
                        NavigationLink(destination:
                                        PlaylistView(
                                            dbCon: $dbCon,
                                            player: self.$player,
                                            playlist: playlist)){
                            PlaylistElementView(playlist: playlist)
                                .onLongPressGesture(){
                                    playlistToDelete = playlist
                                }
                        }
                    }
                }
            PlayerBarView(player: self.player)
        }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/)
        .navigationTitle("Playlists")
        .toolbar {
                Button("New") {
                    showingSheet.toggle()
                }
        }
        .alert(item: $playlistToDelete, content: { playlist in
            Alert(
                title: Text("Deleting"),
                message: Text("Do you want to delete \(playlist.name)?"),
                primaryButton: .destructive(Text("Delete"), action: {
                    dbCon.removePlaylist(id: playlist.id!)
                    playlists.remove(at: playlists.firstIndex(of: playlist)!)
                }),
                secondaryButton: .cancel(Text("Cancel"))
            )
        })
        .onAppear(perform: {
            playlists = dbCon.getPlaylists()
        })
            
            
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
                    dbCon.addPlaylist(playlist: Playlist(name:playlistName))
                    playlists = DBCon().getPlaylists()
                    showingSheet.toggle()
                    playlistName = ""
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
        PlaylistsView(dbCon: Binding.constant(DBCon()), player: Binding.constant(Player()), playlists: Playlist.data)
    }
}
