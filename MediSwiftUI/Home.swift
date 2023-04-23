//
//  Home.swift
//  MediSwiftUI
//
//  Created by Kullanici on 16.04.2023.
//

import SwiftUI


struct Album: Hashable {
    var id = UUID()
    var name: String
    var image: String
    var songs: [Song]
}

struct Song: Hashable {
    var id = UUID()
    var name: String
    var time: String
    var file: String
    var image: String
}

struct Home: View {
    
    @ObservedObject var data: OurData
    @State private var currentAlbum: Album?
    
    let columns: [GridItem] = [
        GridItem(.fixed(50))
    ]
    var body: some View {
        
        NavigationView {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack {
                        ForEach(self.data.albums, id: \.self, content: { album in
                            AlbumArt(album: album, isWithText: true).onTapGesture {
                                self.currentAlbum = album
                            }
                        })
                    }
                })
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    if self.data.albums.first == nil {
                        EmptyView()
                    } else {
                        ForEach((self.currentAlbum?.songs ?? self.data.albums.first?.songs) ?? [Song(name: "", time: "", file: "", image: "")], id: \.self) { song in
                            SongCell(album: currentAlbum ?? self.data.albums.first!, song: song)
                        }
                    }
                }
                .background(self.currentAlbum == nil ? Color.clear : Color.clear)
                    
            }
            .navigationTitle("MindSerenity").foregroundColor(.white)
            .background(
                Image("resim10") // Arka plan resminin adını yaz
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all))
        }
    }
}

struct AlbumArt : View {
    var album: Album
    var isWithText: Bool
    var body: some View {
        ZStack(alignment: .bottom, content:  {
            Image(album.image).resizable().aspectRatio(contentMode: .fit).frame(width: 170, height: 200, alignment: .center)
            if isWithText == true {
                ZStack {
                    Blur(style: .dark)
                    Text(album.name).foregroundColor(.white)
                }
                .frame(height: 30, alignment: .center)
            }
        })
            .frame(width: 170, height: 200, alignment: .center).clipped().cornerRadius(20).shadow(radius: 10).padding(20)
    }
}

struct SongCell : View {
    var album: Album
    var song: Song
    var body: some View {
        NavigationLink(destination: PlayerView(album: album, song: song), label: {
                    ZStack(alignment: .bottom, content:  {
                        Image(song.image).resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 130, alignment: .center)
                        ZStack {
                            Blur(style: .dark)
                            Text(song.name).foregroundColor(.white)
                        }
                        .frame(height: 30, alignment: .center)
                    })
                        .frame(width: 100, height: 130, alignment: .center).clipped().cornerRadius(20).shadow(radius: 10).padding(20)              
          
         
        }).buttonStyle(PlainButtonStyle())
    }
}

