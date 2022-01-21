//
//  ContentView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State var dbCon: DBCon
    @Binding var player: Player
    var body: some View {
        VStack{
            TabView{
                List{
                    NavigationLink(destination: PlaylistsView(dbCon: $dbCon, player: self.$player)){
                        Text("Playlists")
                    }
                    NavigationLink(destination: AlbumsView(dbCon: $dbCon, player: self.$player)){
                        Text("Albums")
                    }
                    NavigationLink(destination: SongsView(player: self.$player, dbCon: self.$dbCon)){
                        Text("Songs")
                    }.accessibilityIdentifier("songs")
                }
            }
            .tabViewStyle(PageTabViewStyle())
            Image("logo")
                .resizable()
                .frame(width: 170.0, height: 170.0)
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0))
            PlayerBarView(player: self.player)
        }
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 1.0, brightness: 0.001, opacity: 0.105)/*@END_MENU_TOKEN@*/)
        .navigationTitle("Menu")
        .accessibilityLabel("contentView")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ContentView(dbCon: DBCon(), player: Binding.constant(Player()))
        }
    }
}
