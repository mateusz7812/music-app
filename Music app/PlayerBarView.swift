//
//  PlayerBarView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI
import AVKit

struct PlayerBarView: View {
    @ObservedObject var player: Player
    @State private var showingSheet = false
    var body: some View {
        HStack{
            SavedImage.loadIfExists(imageName: player.currentSong.album?.artworkPath)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(5)
            VStack(alignment: .leading){
                Text($player.currentSong.name.wrappedValue)
                    .font(.system(size: 16))
                Text($player.currentSong.author.wrappedValue)
                    .font(.system(size: 14))
            }
            Spacer()
            
            if (!$player.isPlaying.wrappedValue) {
                Button(action: {
                    self.player.play()
                }){
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width: 17, height: 17, alignment: Alignment.center)
                }
                .accessibility(identifier: "play_button")
            } else {
                Button(action: {
                    self.player.pause()
                }){
                    Image(systemName: "pause.fill")
                        .resizable()
                        .frame(width: 17, height: 17, alignment: Alignment.center)
                }
                .accessibility(identifier: "pause_button")
            }
            
            Button(action: {
                player.switchToNextSong()
            }){
                Image(systemName: "forward.fill")
                    .resizable()
                    .frame(width: 25, height: 17, alignment: Alignment.center)
            }
            .padding(.trailing, 20)
            .padding(.leading, 5)
        }.onTapGesture(perform: {
            showingSheet.toggle()
        })
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
        .sheet(isPresented: $showingSheet){
            PlayerView(player: self.player, song: Song.data[0])
        }
    }
}

struct PlayerBarView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerBarView(player: Player())
    }
}
