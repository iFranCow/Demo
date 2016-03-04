//
//  ViewController.swift
//  Tap Me
//
//  Created by Franco Cheng on 8/1/2016.
//  Copyright © 2016 iFranCow. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    var count = 0
    var seconds = 0
    var timer = NSTimer()
    
    var buttonBeep: AVAudioPlayer?
    var secondBeep: AVAudioPlayer?
    var backgroundMusic: AVAudioPlayer?
    
    
    @IBAction func buttonPressed() {
        
        buttonBeep?.play()
        count++
        scoreLabel.text = "Score \(count)"
    }
    
    func setupGame() {
        seconds = 30
        count = 0
        
        timerLabel.text = "\(seconds)"
        scoreLabel.text = "Score: \(count)"
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: ("subtractTime"), userInfo: nil, repeats: true)
        
        backgroundMusic?.volume = 0.3
        backgroundMusic?.play()
    }
    
    func setupAudioPlayerWtihFile(file: String, type: String) -> AVAudioPlayer? {
        
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        let url = NSURL.fileURLWithPath(path!)
        
        var audioPlayer: AVAudioPlayer?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("Player not available")
        }
        
        return audioPlayer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let buttonBeep = self.setupAudioPlayerWtihFile("ButtonTap", type: "wav") {
            self.buttonBeep = buttonBeep
        }
        
        if let secondBeep = self.setupAudioPlayerWtihFile("SecondBeep", type: "wav") {
            self.secondBeep = secondBeep
        }
        
        if let backgroundMusic = self.setupAudioPlayerWtihFile("HallOfTheMountainKing", type: "mp3") {
            self.backgroundMusic = backgroundMusic
        }
        
        setupGame()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func subtractTime() {
        seconds--
        timerLabel.text = "\(seconds)"
        
        if seconds == 0 {
            timer.invalidate()
            
            let alert = UIAlertController(title: "Time is up", message: "You scored \(count) points", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Play again", style: .Default, handler: {
                action in self.setupGame()
            }))
            
            presentViewController(alert, animated: true, completion: nil)
        }
        secondBeep?.play()
    }
}

