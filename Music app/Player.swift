//
//  Player.swift
//  Music app
//
//  Created by stud on 08/11/2021.
//

import SwiftUI
import AVKit

struct Player: View {
    @State var audioPlayer: AVAudioPlayer!
    @State var playing = false;
    @Binding var sliderValue: Float;
    let song: Song;
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
            Slider(value: $sliderValue, in: 0...30, step: 1)
            HStack{
                Spacer()
                Image(systemName: "backward.fill")
                    .resizable()
                    .frame(width: 40, height: 20, alignment: Alignment.center)
                Spacer()
                if (!playing) {
                    Button(action: {
                        self.audioPlayer.play()
                        playing.toggle();
                    }){
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 30, height: 30, alignment: Alignment.center)
                    }
                } else {
                    Button(action: {
                        self.audioPlayer.pause()
                        playing.toggle();
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
        }.onAppear{
            let sound = Bundle.main.path(forResource: "sample4", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        }
    }
}

struct Player_Previews: PreviewProvider {
    static var previews: some View {
        Player(sliderValue: Binding.constant(10), song: Song.data[0])
    }
}
