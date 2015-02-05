//
//  ViewController.swift
//  PlayAudioTest
//
//  Created by Yotam Sher on 2/4/15.
//  Copyright (c) 2015 tamshi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    /// The player.
    var avPlayer:AVAudioPlayer!

    @IBAction func doPlay(sender: AnyObject) {
        self.toggleAVPlayer()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let fileURL:NSURL = NSBundle.mainBundle().URLForResource("alef", withExtension: "mp3")!
        var error: NSError?
        self.avPlayer = AVAudioPlayer(contentsOfURL: fileURL, error: &error)
        if avPlayer == nil {
            if let e = error {
                println(e.localizedDescription)
            }
        }
        avPlayer.delegate = self
        avPlayer.prepareToPlay()
        avPlayer.volume = 1.0
        // Do any additional setup after loading the view, typically from a nib.
    }

    func stopAVPLayer() {
        if avPlayer.playing {
            avPlayer.stop()
        }
    }
    
    func toggleAVPlayer() {
        if avPlayer.playing {
            avPlayer.pause()
        } else {
            avPlayer.play()
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
    // MARK: AVAudioPlayerDelegate
    extension ViewController : AVAudioPlayerDelegate {
        func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
            println("finished playing \(flag)")
        }
        
        
        func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
            println("\(error.localizedDescription)")
        }

    }

