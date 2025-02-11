//
//  IntroViewController.swift
//  COVID19 Tracker
//
//  Created by kishore saravanan on 13/04/20.
//  Copyright © 2020 kishore saravanan. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class IntroViewController: UIViewController {
    @IBOutlet weak var VideoContentView: AVPlayerView!
    
    var index: Int?
    var VideoName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: VideoName, ofType: "mov")! )
        let avPlayer = AVPlayer(url: path)
        let castedLayer = VideoContentView.layer as! AVPlayerLayer
        castedLayer.player = avPlayer
        avPlayer.play()
        avPlayer.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        NotificationCenter.default.addObserver(self, selector: #selector(IntroViewController.videoDidPlayToEnd(_:)), name: NSNotification.Name(rawValue: "AVPlayerItemDidPlayToEndTimeNotification"), object: avPlayer.currentItem)
        
    }
    @objc func videoDidPlayToEnd(_ notification: Notification) {
        let player: AVPlayerItem = notification.object as! AVPlayerItem
        player.seek(to: CMTime.zero)
    }
    
}
