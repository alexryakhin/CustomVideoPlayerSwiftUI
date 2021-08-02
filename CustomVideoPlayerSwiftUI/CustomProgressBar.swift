//
//  CustomProgressBar.swift
//  CustomProgressBar
//
//  Created by Alexander Bonney on 7/29/21.
//

import SwiftUI
import AVKit

struct CustomProgressBar: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return CustomProgressBar.Coordinator(parent: self)
    }
    
    @Binding var player: AVPlayer
    @Binding var value: Float
    @Binding var isplaying: Bool
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumTrackTintColor = .systemBlue
        slider.maximumTrackTintColor = .gray
        slider.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
//        slider.thumbTintColor = .red
        slider.value = value
        slider.addTarget(context.coordinator, action: #selector(context.coordinator.changed), for: .valueChanged)
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = value
    }
    
    class Coordinator: NSObject {
        
        var parent: CustomProgressBar
        
        init(parent: CustomProgressBar) {
            self.parent = parent
        }
        @objc func changed(slider: UISlider) {
            if slider.isTracking {
                parent.player.pause()
                let sec = Double(slider.value * Float((parent.player.currentItem?.duration.seconds)!))
                parent.player.seek(to: CMTime(seconds: sec, preferredTimescale: 1))
            } else {
                let sec = Double(slider.value * Float((parent.player.currentItem?.duration.seconds)!))
                parent.player.seek(to: CMTime(seconds: sec, preferredTimescale: 1))
                
                if parent.isplaying {
                    parent.player.play()
                }
            }
        }
    }
}
