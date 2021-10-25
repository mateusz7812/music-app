//
//  SectionButtonView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI

struct SectionButtonView: View {
    let text: String
    var body: some View {
            HStack{
                Text(text)
                Spacer()
                Image(systemName: "forward.fill")
            }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
    }
}

struct SectionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SectionButtonView(text: "test")
    }
}
