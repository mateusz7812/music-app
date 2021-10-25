//
//  Duration.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import Foundation

struct Duration{
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    func to_String() -> String {
        return String(format: "%d:%d:%d", hours, minutes, seconds)
    }
}
