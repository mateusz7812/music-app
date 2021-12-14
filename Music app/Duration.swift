//
//  Duration.swift
//  Music app
//
//  Created by stud on 25/10/2021.
//

import Foundation
import SQLite

class Duration{
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    public init(hours: Int, minutes: Int, seconds: Int){
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
    
    
    func to_String() -> String {
        return String(format: "%d:%d:%d", hours, minutes, seconds)
    }
}

extension Duration: Value{
    public class var declaredDatatype: String {
        return Int64.declaredDatatype
        }
    
    public class func fromDatatypeValue(_ datatypeValue: Int64) -> Duration {
        return Duration.from(Int(datatypeValue))
    }

    public var datatypeValue: Int64 {
        return Int64(self.toSeconds)
    }
}

extension Duration{
    public static func from(_ seconds: Int) -> Duration{
        let h: Int = seconds/3600
        let m: Int = (seconds - (3600 * h))/60
        let s: Int = seconds - (3600 * h) - (60 * m)
        return Duration(hours: h, minutes: m, seconds: s)
    }
    
    public var toSeconds: Int{
        return 3600 * hours + 60 * minutes + seconds
    }
    
    public var toString: String{
        var str = ""
        if hours != 0 {
            str += "\(hours):"
        }
        str += "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
        return str
    }
}
