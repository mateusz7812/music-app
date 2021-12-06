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
            var h: Int = Int(datatypeValue)/3600
            var m: Int = (Int(datatypeValue) - (3600 * h))/60
            var s: Int = Int(datatypeValue) - (3600 * h) - (60 * m)
            return Duration(hours: h, minutes: m, seconds: s)
        }
    
        public var datatypeValue: Int64 {
            return Int64(3600 * hours + 60 * minutes + seconds)
        }
}
