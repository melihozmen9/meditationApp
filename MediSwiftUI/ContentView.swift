//
//  ContentView.swift
//  MediSwiftUI
//
//  Created by Kullanici on 13.04.2023.
//

import SwiftUI



struct ContentView: View {
    

    @ObservedObject var data: OurData
    @State private var currentAlbum: Album?
    
    
    var body: some View {

        Home(data: data)
    }
}

