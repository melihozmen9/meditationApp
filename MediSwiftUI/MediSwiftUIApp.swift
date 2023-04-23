//
//  MediSwiftUIApp.swift
//  MediSwiftUI
//
//  Created by Kullanici on 13.04.2023.
//

import SwiftUI
import Firebase
@main
struct MediSwiftUIApp: App {
     let data = OurData()
    init() {
        FirebaseApp.configure()
        data.loadAlbums() // on the loading iof the application we should able to see all of the data coming through  in console
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(data: data)
        }
    }
}
