//
//  PlayerView.swift
//  MediSwiftUI
//
//  Created by Kullanici on 13.04.2023.
//

import Foundation
import SwiftUI
import FirebaseStorage
import AVFoundation

struct PlayerView: View {
    var album: Album
    var song: Song
    
    @State var player = AVPlayer()
    @State var isPlaying: Bool = true
    @State var progress: Float = 0.0
    
    var body: some View {
        ZStack {
            Image(song.time).resizable().edgesIgnoringSafeArea(.all)
            Blur(style: .dark).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Image(song.time).resizable().aspectRatio(contentMode: .fit).frame(width: 170, height: 200, alignment: .center)
                ZStack{
                    Blur(style: .light).edgesIgnoringSafeArea(.all)

                Text(song.name).font(.title).fontWeight(.light).accentColor(.white)
                
                }
                Spacer()
                VStack {
                    ProgressView(value: progress)
                        .foregroundColor(.white).padding(20)
                    Button(action: self.playPause, label: {
                        Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill").resizable()
                    }).frame(width: 70, height: 70, alignment: .center).foregroundColor(.white)
                    
                }
                .edgesIgnoringSafeArea(.bottom).frame(height: 200, alignment: .center)
            }
        }.onAppear() {
            let storage = Storage.storage().reference(forURL: self.song.file)
            storage.downloadURL { (url, error) in
                if error != nil {
                    print(error)
                }else  {
                    print(url?.absoluteString)
                    player = AVPlayer(playerItem : AVPlayerItem(url: url!))
                    player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: DispatchQueue.main) { time in
                        let duration = self.player.currentItem?.duration.seconds ?? 0
                        self.progress = Float(time.seconds / duration)
                    }
                    player.play()
                }
            }
            
            UINavigationBar.appearance().tintColor = .white
        }
    }
    
    func playPause() {
        self.isPlaying.toggle()
        if isPlaying == true {
            player.pause()
        } else {
            player.play()
        }
    }
   
}
