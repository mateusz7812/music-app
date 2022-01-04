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
            Text(audioPlayer.currentSong.name)
                .font(.system(size: 20))
                .padding(1)
            if(audioPlayer.currentSong.album != nil){
                Text(audioPlayer.currentSong.album!.name)
                    .font(.system(size: 16))
            }
            Text(audioPlayer.currentSong.author)
                .font(.system(size: 16))
            Spacer()
            HStack{
                Text(Duration.from(Int(audioPlayer.currentTime)).toString)
                Spacer()
                Text(Duration.from(Int(audioPlayer.duration)).toString)
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            Slider(
                value: Binding(get: { audioPlayer.currentTime }, set: { (newVal) in audioPlayer.set(time: newVal) }),
                in: 0...$audioPlayer.duration.wrappedValue,
                step: 1
            )
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            HStack{
                Spacer()
                Button(action: {
                    self.audioPlayer.switchToLastSong()
                }){
                    Image(systemName: "backward.fill")
                        .resizable()
                        .frame(width: 40, height: 20, alignment: Alignment.center)
                }
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
                Button(action: {
                    self.audioPlayer.switchToNextSong()
                }){
                    Image(systemName: "forward.fill")
                        .resizable()
                        .frame(width: 40, height: 20, alignment: Alignment.center)
                }
                Spacer()
            }
            HStack{
                Spacer()
                Button(action: {
                    audioPlayer.shuffling.toggle()
                }){
                    if($audioPlayer.shuffling.wrappedValue){
                        Image(systemName: "shuffle")
                            .resizable()
                            .frame(width: 25, height: 15, alignment: Alignment.center)
                            .foregroundColor(.blue)
                    } else {
                        Image(systemName: "shuffle")
                            .resizable()
                            .frame(width: 25, height: 15, alignment: Alignment.center)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
                Button(action: {
                    audioPlayer.infinitePlaying.toggle()
                }){
                    if($audioPlayer.infinitePlaying.wrappedValue){
                        Image(systemName: "infinity")
                            .resizable()
                            .frame(width: 25, height: 15, alignment: Alignment.center)
                            .foregroundColor(.blue)
                    } else {
                        Image(systemName: "infinity")
                            .resizable()
                            .frame(width: 25, height: 15, alignment: Alignment.center)
                            .foregroundColor(.gray)
                    }
                }
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
