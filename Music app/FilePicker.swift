//
//  FilePicker.swift
//  Music app
//
//  Created by Mac Mini on 14/12/2021.
//

import SwiftUI

struct FilePicker: View {
    @Binding var path: String
    @State var filename = "Filename"
    @State var showFileChooser = false

     var body: some View {
       HStack {
        Text(filename)
            .lineLimit(2)
        Button("Choose file") {
            let picker = DocumentPickerViewController(
                supportedTypes: ["public.item"],
                onPick: { url in
                    filename = url.lastPathComponent
                    path = url.path
                    print("url : \(url)")
                    print("path : \(path)")
                },
                onDismiss: {
                    print("dismiss")
                }
            )
            UIApplication.shared.windows.first?.rootViewController?.present(picker, animated: true)
        }
       }
       .frame(maxWidth: .infinity, maxHeight: .infinity)
     }
}

struct FilePicker_Previews: PreviewProvider {
    static var previews: some View {
        FilePicker(path: Binding.constant(""))
    }
}
