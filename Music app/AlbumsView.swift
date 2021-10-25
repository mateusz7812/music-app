//
//  AlbumsView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI

struct AlbumsView: View {
    var body: some View {
        VStack{
            Spacer()
            PlayerBarView()
            
        }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/)
        .navigationTitle("Albums")
    }
}

struct AlbumsView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumsView()
    }
}
