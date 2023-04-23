//
//  Data.swift
//  MediSwiftUI
//
//  Created by Kullanici on 14.04.2023.
//
// Handle all the data coming in. andd
import Foundation
import SwiftUI
import Firebase

class OurData: ObservableObject {
    @Published public var albums = [Album]()
    func loadAlbums() {
        Firestore.firestore().collection("albums").getDocuments { (snapshot, error) in
            if error == nil {
                for document in snapshot!.documents {
                    let name = document.data()["name"] as? String ?? "error"
                    let image = document.data()["image"] as? String ?? "error"
                    let songs = document.data()["songs"] as? [String : [String: Any]]
                    
                    var songArray = [Song]()
                    if let songs = songs {
                        for song in songs {
                            let songName = song.value["name"] as? String ?? "error"
                            let songTime = song.value["time"] as? String ?? "error"
                            let songFile = song.value["file"] as? String ?? "error"
                            let songImage = song.value["image"] as? String ?? "error"
                            songArray.append(Song(name: songName, time: songTime, file: songFile, image: songImage))
                        }
                    }
                    self.albums.append(Album(name: name, image: image, songs: songArray))
                }
                
            }else {
                print(error)
            }
        }
    }
}
