//
//  Music_appApp.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import SwiftUI
import AVKit

@main
struct Music_appApp: App {
    var db = DBCon()
    var audioPlayer: Player = Player()
    
    init(){
        db.createTables()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView(dbCon: db, player: Binding.constant(self.audioPlayer))
            }
        }
    }
}
