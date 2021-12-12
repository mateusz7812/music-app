//
//  Player.swift
//  Music app
//
//  Created by stud on 08/11/2021.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    @ObservedObject var audioPlayer: Player
    //@Binding private var playing: Bool
    //@Binding private var sliderValue: Float
    let song: Song
    
    public init(player: Player, song: Song){
        self.song = song
        audioPlayer = player
        //_playing = $audioPlayer.isPlaying
        //_sliderValue = $audioPlayer.sliderValue
    }
    
    var body: some View {
        VStack{
            Image("sample")
                .resizable()
                .scaledToFit()
                .padding(10)
            Text("Song name")
            Text("Album")
            Text("Author")
            Spacer()
            HStack{
                Text("1:45")
                Spacer()
                Text("3:30")
            }
            Slider(value: $audioPlayer.sliderValue, in: 0...30, step: 1)
            HStack{
                Spacer()
                Image(systemName: "backward.fill")
                    .resizable()
                    .frame(width: 40, height: 20, alignment: Alignment.center)
                Spacer()
                if (!$audioPlayer.isPlaying.wrappedValue) {
                    Button(action: {
                        self.audioPlayer.play()
                    }){
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 30, height: 30, alignment: Alignment.center)
                    }
                } else {
                    Button(action: {
                        self.audioPlayer.pause()
                    }){
                        Image(systemName: "pause.fill")
                            .resizable()
                            .frame(width: 30, height: 30, alignment: Alignment.center)
                    }
                }
                Spacer()
                Image(systemName: "forward.fill")
                    .resizable()
                    .frame(width: 40, height: 20, alignment: Alignment.center)
                Spacer()
            }
            HStack{
                Spacer()
                Image(systemName: "shuffle")
                    .resizable()
                    .frame(width: 25, height: 15, alignment: Alignment.center)
                Spacer()
                Image(systemName: "infinity")
                    .resizable()
                    .frame(width: 25, height: 15, alignment: Alignment.center)
                Spacer()
            }
            Spacer()
        }
    }
}

struct Player_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(player: Player(), song: Song.data[0])
    }
}
