//
//  PlayerBarView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI

struct PlayerBarView: View {
    var body: some View {
        HStack{
            Image(systemName: "forward.fill")
            VStack(alignment: .leading){
                Text("song_name")
                Text("author")
            }
            Spacer()
            Button(action: {}){
                Image(systemName: "forward.fill")
            }
            Button(action: {}){
                Image(systemName: "forward.fill")
            }
            
        }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
    }
}

struct PlayerBarView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerBarView()
    }
}
