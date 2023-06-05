//
//  ViewController.swift
//  SilentWake
//
//  Created by Ok Hyeon Kim on 2023/05/03.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        guard let url = Bundle.main.url(forResource: "Alarm1", withExtension: "mp3") else {
            return
        }

        player = try! AVAudioPlayer(contentsOf: url)
        player.prepareToPlay()
        player.volume = 0.5
        player.numberOfLoops = -1
        player.play()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            print(self.player.isPlaying)
            self.player.volume = 1.0
        })
    }
}

