//
//  ViewController.swift
//  Crystal Echo
//
//  Created by Issac Greenfield on 10/30/15.
//  Copyright © 2015 Issac Greenfield. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    private var counter: Int = 1
    private var playState: Bool = false
    private var shardPattern: [Int] = []

    @IBAction func buttonPressed(sender: UIButton) {
        print("good job, ikies!")
        print((sender.titleLabel?.text)!)
//        self.playSound(Int((sender.titleLabel?.text)!)!)
        self.playButton(Int((sender.titleLabel?.text)!)!)
    }
    
    private func playButton(buttonNumber: Int)
    {
        self.playSound(buttonNumber)
        self.shardPattern.append(buttonNumber)
        self.playState = true
    }
    
    private func playSound(buttonNumber: Int)
    {
        let soundURL = NSBundle.mainBundle().URLForResource("\(buttonNumber)", withExtension: "wav")
        var mySound: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundURL!, &mySound)
        AudioServicesPlaySystemSound(mySound);
        
    }

    private func setPattern(shardPattern: [Int])
    {
        self.shardPattern = shardPattern
    }
    
    func runTimedCode() {
        
        if self.playState == true
        {
            if self.counter <= self.shardPattern.count
            {
                playSound(self.shardPattern[self.counter - 1])
                self.counter++
            } else
            {
                self.counter = 1
                self.playState = false
            }
        }else
        {
            print(self.counter)
        }
    }
    
    override func viewDidLoad() {
//        var gameTimer: NSTimer!

        let gameTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "runTimedCode", userInfo: nil, repeats: true)
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

