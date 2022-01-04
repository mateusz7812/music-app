//
//  AlbumsView.swift
//  Music app
//
//  Created by stud on 25/10/2021.
import UIKit
import SwiftUI
import AVKit
import HalfASheet

struct AlbumsView: View {
    @Binding var dbCon: DBCon
    @Binding var player: Player
    @State private var showingSheet = false;
    @State private var albumName = "";
    @State private var albumAuthors = "";
    @State var albums: [Album] = []
    @State private var albumToDelete: Album?
    
    fileprivate func downloadImage(_ imagePath: String) -> URL{
        let url = URL(string: imagePath)!
        
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let artworkURL = URL(fileURLWithPath: documents + "/" + url.lastPathComponent)
        
        let exists = FileManager.default.fileExists(atPath: artworkURL.path)
        if(exists == false){
            FileDownloader.load(url: url, to: artworkURL, completion: {})
        }
        return artworkURL
    }
    
    fileprivate func getLinkAndDownloadArtWork(_ url: URL, album_id: Int) {
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                    let imagePath = ((json!["album"]!["image"]!! as! [AnyObject])[5] as! [String:String])["#text"]!
                    if(imagePath != ""){
                        let artworkURL = downloadImage(imagePath)
                        dbCon.addArtworkToAlbum(album_id: album_id, artwork_path: artworkURL.lastPathComponent)
                    }
                } catch {
                    print("artwork path not found")
                    print(String(data: data, encoding: .utf8)!)
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }
    
    var body: some View {
        ZStack{
        VStack{
            TabView{
                List{
                    ForEach(albums, id: \.name){ album in
                        NavigationLink(destination:
                                        AlbumSongsView(
                                            dbCon: $dbCon,
                                            player: self.$player,
                                            album: album)){
                                AlbumElementView(album: album)
                                .onLongPressGesture(){
                                    albumToDelete = album
                                }
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            Spacer()
            PlayerBarView(player: self.player)
            
        }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/)
        .navigationTitle("Albums")
        .toolbar {
                Button("New") {
                    showingSheet.toggle()
                }
        }
        .alert(item: $albumToDelete, content: { album in
            Alert(
                title: Text("Deleting"),
                message: Text("Do you want to delete \(album.name) - \(album.authors)"),
                primaryButton: .destructive(Text("Delete"), action: {
                    dbCon.removeAlbum(id: album.id!)
                    albums.remove(at: albums.firstIndex(of: album)!)
                }),
                secondaryButton: .cancel(Text("Cancel"))
            )
        })
        .onAppear(perform:{
            albums = dbCon.getAlbums()
        })
        
        HalfASheet(isPresented: $showingSheet, title: "New album"){
            VStack{
                List{
                    Section{
                        TextField("Name", text: $albumName)
                        TextField("Authors", text: $albumAuthors)
                    }
                }
                .padding(.top, 10.0)
                .listStyle(InsetGroupedListStyle())
                Button("Add"){
                    print("playlist \(albumName) adding")
                    let album_id = dbCon.addAlbum(album: Album(name: albumName, authors: albumAuthors))
                    
                    let authorsEncoded = albumAuthors.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                    let nameEncoded = albumName.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                    
                    let url = URL(string: "https://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=34353b23f4d972138c615c4b4906607e&artist=\(authorsEncoded)&album=\(nameEncoded)&format=json&autocorrect=1")!

                    getLinkAndDownloadArtWork(url, album_id: album_id!)
                    
                    albums = dbCon.getAlbums()
                    showingSheet.toggle()
                    albumName = ""
                    albumAuthors = ""
                }
                Spacer()
            }
        }
        .height(.proportional(0.5))
        .backgroundColor(UIColor.systemGroupedBackground)
        }
    }
}

struct AlbumsView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumsView(dbCon: Binding.constant(DBCon()),player: Binding.constant(Player()), albums: Album.data)
    }
}
