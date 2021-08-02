//
//  ControlsView.swift
//  ControlsView
//
//  Created by Alexander Bonney on 7/29/21.
//

import SwiftUI
import AVKit

struct Controls: View {
    @Binding var player: AVPlayer
    @Binding var isPlaying: Bool
    @Binding var showingControls: Bool
    @Binding var value: Float
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    //backward
                    player.seek(to: CMTime(seconds: getSeconds() - 10, preferredTimescale: 1))
                } label: {
                    Image(systemName: "backward.fill").font(.title).foregroundColor(.white)
                }.padding(20)
                Spacer()
                Button {
                    //play
                    if isPlaying {
                        player.pause()
                        isPlaying = false
                    } else {
                        player.play()
                        isPlaying = true
                    }
                } label: {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.title)
                        .foregroundColor(.white)
                }.padding(20)
                Spacer()
                Button {
                    //forward
                    player.seek(to: CMTime(seconds: getSeconds() + 10, preferredTimescale: 1))
                } label: {
                    Image(systemName: "forward.fill").font(.title).foregroundColor(.white)
                }.padding(20)
                Spacer()
            }
            Spacer()
            
            CustomProgressBar(player: $player, value: $value, isplaying: $isPlaying)
        }.padding().background(Color.black.opacity(0.4)).onTapGesture {
            withAnimation() {
                showingControls = false
            }
        }.onAppear {
            player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main) { _ in
                //
                value = getSliderValue()
                
                if value == 1.0 {
                    isPlaying = false
                }
            }
        }
    }
    
    func getSliderValue() -> Float {
        return Float(player.currentTime().seconds / (player.currentItem?.duration.seconds)!)
    }
    
    func getSeconds() -> Double {
        return Double(Double(value) * (player.currentItem?.duration.seconds)!)
    }
}

