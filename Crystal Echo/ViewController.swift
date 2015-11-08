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
    private var startNewGame: Bool = true


    @IBAction func buttonPressed(sender: UIButton) {
        self.view.userInteractionEnabled = false
        self.playButton(Int((sender.titleLabel?.text)!)!)
        self.view.userInteractionEnabled = true
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
        
        if self.startNewGame == true
        {
            self.startMessage()
            self.startNewGame = false
            self.playState = true
        }else
        {
            if self.playState == true
            {
                self.view.userInteractionEnabled = false
                if self.counter <= self.shardPattern.count
                {
                    playSound(self.shardPattern[self.counter - 1])
                    self.counter++
                } else
                {
                    self.counter = 1
                    self.playState = false
                    self.view.userInteractionEnabled = true
                }
            }else   //While the timer is not being used
            {
                //            print(self.counter)
            }
        }
    }
    
    private func startMessage()
    {
        let alertController = UIAlertController(title: "Welcome To", message:
            "Crystal Echo", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Start!", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {

        let gameTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "runTimedCode", userInfo: nil, repeats: true)
       
        self.view.userInteractionEnabled = false
        
        super.viewDidLoad()
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

