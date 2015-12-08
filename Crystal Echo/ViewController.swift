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
    
    //UI Elements
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    //Model Objects
    private let gameBrain = GameBrain.init()
    private let play = MusicBrain.init()
    
    //GameState Setting Global Variables: are both of these needed?
    private var waitABeat: Bool = false
    private var waitForUser: Bool = true
    private var pauseTimer: Bool = true
    
    //Temp Global Variables to be phased out (GV Bad!!)
    private var shardPattern: [Int] = []
    private var shardPlaceCounter: Int = 0   //move over to GameBrain

    
    //User Interaction Functions
    @IBAction func buttonPressed(sender: UIButton)
    {
        self.view.userInteractionEnabled = false
        self.play.playShard(Int((sender.titleLabel?.text)!)!)
        self.waitABeat = true
        
        if (Int((sender.titleLabel?.text)!)! != self.shardPattern[self.shardPlaceCounter])
        {
            self.waitForUser = false
            self.gameOverMessage()
        }else if (Int((sender.titleLabel?.text)!)! == self.shardPattern[self.shardPlaceCounter])
        {
            shardPlaceCounter++
            if self.shardPlaceCounter == self.shardPattern.count
            {
                self.waitForUser = false
                self.shardPlaceCounter = 0
            }else
            {
                self.view.userInteractionEnabled = true
            }
        }else
        {
            print("Something is wrong with the shard recogonition")
        }
    }
    
    //Automatic Functions
    private func startNewGame()
    {
        self.resetGameBrainPatternSettings()
        play.playShard(self.shardPattern[self.shardPlaceCounter])
        self.waitForUser = true
        self.view.userInteractionEnabled = true
        self.pauseTimer = false
        let gameTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "runTimedCode", userInfo: nil, repeats: true)
    }
    
    func runTimedCode()
    {
        if self.pauseTimer == true
        {
            
        }else if self.pauseTimer == false
        {
            if self.waitABeat == true
            {
                self.waitABeat = false
            }else if self.waitABeat == false
            {
                if self.waitForUser == false && self.shardPlaceCounter <= self.shardPattern.count
                {
                    self.waitABeat = false
                    if self.shardPlaceCounter < self.shardPattern.count
                    {
//                        self.toggleShardStateOff(self.shardPattern[self.shardPlaceCounter - 1])  //this is a problem
                        play.playShard(self.shardPattern[self.shardPlaceCounter])
//                        self.toggleShardStateOn(self.shardPattern[self.shardPlaceCounter])
                        self.shardPlaceCounter++
                    }else if self.shardPlaceCounter == self.shardPattern.count
                    {
                        gameBrain.addToPatern()
                        self.shardPattern = gameBrain.getDynamicPattern()
                        play.playShard(self.shardPattern[self.shardPlaceCounter])
                        self.shardPlaceCounter = 0
                        self.waitForUser = true
                        self.waitABeat = true
                        self.view.userInteractionEnabled = true
                    }else
                    {
                        print("your shardPlaceCounter is out of it's bounds")
                    }
                }
            }

        }
    }
    
    private func toggleShardStateOn(touchedShard: Int)
    {
        switch touchedShard
        {
        case 1:
            button1.highlighted = true
        case 2:
            button2.highlighted = true
        case 3:
            button2.highlighted = true
        case 4:
            button2.highlighted = true
        case 5:
            button2.highlighted = true
        default:
            print("no button was toggled")
        }
    }
    
    private func toggleShardStateOff(touchedShard: Int)
    {
        switch touchedShard
        {
        case 1:
            button1.highlighted = false
        case 2:
            button2.highlighted = false
        case 3:
            button2.highlighted = false
        case 4:
            button2.highlighted = false
        case 5:
            button2.highlighted = false
        default:
            print("no button was toggled")
        }
    }

    private func resetGameBrainPatternSettings()  //to be moved to gamebrain
    {
        self.pauseTimer = true
        self.waitABeat = true
        self.shardPlaceCounter = 0
        self.shardPattern = []
        self.gameBrain.resetPattern()
        self.shardPattern = self.gameBrain.getDynamicPattern()
        gameBrain.resetPattern()
    }
    
    //Game Message Functions
    private func startMessage()
    {
        
        let alertController = UIAlertController(title: "Welcome To", message:
            "Crystal Echo", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Start!", style: UIAlertActionStyle.Default,handler: {
            (action: UIAlertAction!) in
            self.startNewGame()
            }
            ))
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    private func gameOverMessage()
    {
        self.resetGameBrainPatternSettings()
        let alertController = UIAlertController(title: "Darn!", message:
            "That Ain't Right", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK, my bad...", style: UIAlertActionStyle.Default,handler: {
            (action: UIAlertAction!) in
            self.startMessage()
            }
            ))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //Override Functions
    override func viewDidLoad() {
        
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