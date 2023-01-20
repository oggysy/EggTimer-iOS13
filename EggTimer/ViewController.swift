//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titleLavel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var timeLeft: UILabel!
    let eggTimes = ["Soft": 3,"Medium": 5,"Hard": 7]
    var player : AVAudioPlayer!
    var timer = Timer()
    
    @IBAction func onPressed(_ sender: UIButton) {
        var secondsPassed = 0
        timer.invalidate()
        guard let hardness = sender.currentTitle, let totalTime = eggTimes[hardness] else { return }
        titleLavel.text = hardness
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if secondsPassed < totalTime {
                    secondsPassed += 1
                let percentageProgress = Float(secondsPassed) / Float(totalTime)
                self.progressBar.progress = percentageProgress
                self.timeLeft.text = String(totalTime - secondsPassed)
                } else {
                    Timer.invalidate()
                    self.titleLavel.text = "Done!"
                    self.playSound()
                }
            }
        
        
    }
    
    func playSound(){
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
