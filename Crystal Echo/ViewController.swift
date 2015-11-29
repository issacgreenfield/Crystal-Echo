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
    
    private var shardPlaceCounter: Int = 1
    private var playState: Bool = false
    private var shardPattern: [Int] = []
    private var wait: Bool = true
    private let newGame = GameBrain.init()
    private let play = MusicBrain.init()
    
    @IBAction func buttonPressed(sender: UIButton)
    {
        self.view.userInteractionEnabled = false
        self.play.playShard(Int((sender.titleLabel?.text)!)!)
        if (Int((sender.titleLabel?.text)!)! != shardPlaceCounter)
        {
            self.gameOverMessage()
            self.wait = true
        }
        else //you played the right shard
        {
            shardPlaceCounter++
            self.view.userInteractionEnabled = true     //this is bad!!!!
        }
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
        if self.shardPlaceCounter == self.shardPattern.count
        {
            self.wait = true
        }else if self.shardPlaceCounter > self.shardPattern.count
        {
            //error handling here, Fix-it
            print("shardPlaceCounter is out of bounds")
            self.startMessage()
        }
        
        if self.wait == true
        {
            //do nothing
        }else
        {
            if self.playState == true
            {
                //Just listen for user interactions
            }else
            {
                if self.shardPlaceCounter < self.shardPattern.count
                {
                    playSound(self.shardPattern[self.shardPlaceCounter - 1])
                    self.shardPlaceCounter++
                } else
                {
                    self.shardPlaceCounter = 1
                    self.playState = true
                    self.view.userInteractionEnabled = true
                }
            }
        }
    }
    
    private func startMessage()
    {

        //handle reseting of data
        self.shardPattern = []
        self.newGame.resetPattern()
        self.shardPattern = self.newGame.getDynamicPattern()

        let alertController = UIAlertController(title: "Welcome To", message:
            "Crystal Echo", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Start!", style: UIAlertActionStyle.Default,handler: {
            (action: UIAlertAction!) in
            let gameTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "runTimedCode", userInfo: nil, repeats: true)
            }
            ))
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    private func gameOverMessage()
    {
        self.playState = false
        let alertController = UIAlertController(title: "Darn!", message:
            "That Ain't Right", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK, my bad...", style: UIAlertActionStyle.Default,handler: {
            (action: UIAlertAction!) in
            self.startMessage()
            }
            ))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        
//        let gameTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "runTimedCode", userInfo: nil, repeats: true)
        
        self.view.userInteractionEnabled = false
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.startMessage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

