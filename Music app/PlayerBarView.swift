//
//  PlayerBarView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI

struct PlayerBarView: View {
    @State private var showingSheet = false;
    var body: some View {
        HStack{
            Image("sample")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(5)
            VStack(alignment: .leading){
                Text("song_name")
                Text("author")
            }
            Spacer()
            Button(action: {}){
                Image(systemName: "play.fill")
                    .resizable()
                    .frame(width: 17, height: 17, alignment: Alignment.center)
            }
            Button(action: {}){
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
            Player(sliderValue: Binding.constant(10), song: Song.data[0])
        }
    }
}

struct PlayerBarView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerBarView()
    }
}
