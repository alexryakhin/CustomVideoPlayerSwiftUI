//
//  VideoPlayer.swift
//  VideoPlayer
//
//  Created by Alexander Bonney on 7/29/21.
//

import SwiftUI
import AVKit

struct VideoPlayer: UIViewControllerRepresentable {
    @Binding var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        //basically scaledToFill for video player
        controller.videoGravity = .resize
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        //
    }
}
