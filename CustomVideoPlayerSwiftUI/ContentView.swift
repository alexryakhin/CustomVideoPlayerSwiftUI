//
//  ContentView.swift
//  CustomVideoPlayerSwiftUI
//
//  Created by Alexander Bonney on 7/29/21.
//

import SwiftUI
import AVKit

struct ContentView: View {
    
    @State private var player = AVPlayer(url: URL(string: "https://www.rmp-streaming.com/media/big-buck-bunny-360p.mp4")!)
    @State var value: Float = 0
    @State private var isPlaying = false
    @State private var showingControls = false
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    ZStack {
                        VideoPlayer(player: $player).onTapGesture {
                            withAnimation() {
                                showingControls = true
                            }
                        }
                        if showingControls {
                            Controls(player: $player, isPlaying: $isPlaying, showingControls: $showingControls, value: $value)
                        }
                    }.ignoresSafeArea().frame(height: geo.size.width < geo.size.height
                            ? geo.size.height / 3.5
                            : geo.size.height)
                    
                }.navigationTitle("Custom Player").navigationBarHidden(geo.size.width > geo.size.height)
            }
        }
        .onAppear {
            player.play()
            isPlaying = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
