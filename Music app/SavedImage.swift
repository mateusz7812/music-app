//
//  SavedImage.swift
//  Music app
//
//  Created by Mac Mini on 04/01/2022.
//

import SwiftUI

struct SavedImage{
    static func getImagePath(_ imageName: String) -> String {
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let destinationPath = URL(fileURLWithPath: documents).appendingPathComponent(imageName).path
        return destinationPath
    }
    
    static func getUIImage(imagePath: String) -> UIImage{
        return UIImage(contentsOfFile: imagePath)!
    }
    
    static func load(imageName: String) -> Image {
        return Image(uiImage: getUIImage(imagePath: getImagePath(imageName)))
    }
    
    static func loadIfExists(imageName: String?) -> Image{
        if(imageName == nil){
            return Image("sample")
        } else {
            return load(imageName: imageName!)
        }
    }
}
