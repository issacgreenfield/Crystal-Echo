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
    private let musicBrain = MusicBrain.init()
    
    //GameState Setting Global Variables
    private var waitABeat: Bool = false
//    private var waitForUser: Bool = true
//    private var pauseTimer: Bool = false
    private var endShardTimerBool: Bool = false
//    private var endShardPatternTimerBool: Bool = false
    private var shardToPlay = 3
    
    //Temp Global Variables to be phased out (GV Bad!!)
//    private var shardPattern: [Int] = []
//    private var shardPlaceCounter: Int = 0   //move over to GameBrain
    var playShardPatternTimercounter = 0
    var playShardTimercounter = 0
    
    //Global Timers
    var playShardTimer = NSTimer()
    var playShardPatternTimer = NSTimer()
    
    //User Interaction Functions
    @IBAction func buttonPressed(sender: UIButton)
    {
        self.view.userInteractionEnabled = false
        musicBrain.playShard(Int((sender.titleLabel?.text)!)!)
        
        if (Int((sender.titleLabel?.text)!)! != gameBrain.getShardPattern()[gameBrain.getShardPlaceCounter()])
        {
            print(Int((sender.titleLabel?.text)!)!, " != ", gameBrain.getShardPattern()[gameBrain.getShardPlaceCounter()])
            self.gameOverMessage()
        }
        else if (Int((sender.titleLabel?.text)!)! == gameBrain.getShardPattern()[gameBrain.getShardPlaceCounter()])
        {
            gameBrain.addToShardPlaceCounter()
            if gameBrain.getShardPlaceCounter() == gameBrain.getShardPattern().count
            {
                self.waitABeat = true
                gameBrain.resetShardPlaceCounter()
                gameBrain.addToPatern()
                self.playShardPatternTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "playShardPatternTimerFunction", userInfo: nil, repeats: true)
            }else
            {
                self.view.userInteractionEnabled = true
            }
        }else
        {
            print("Something is wrong with the shard recogonition")
        }
    }
    
    func playShardPatternTimerFunction()
    {
        playShardPatternTimercounter++
        print("playShardPatternTimercounter: ", playShardPatternTimercounter)
        
        if (self.waitABeat == true)
        {
            self.waitABeat = false
        }
        else
        {
            if (gameBrain.getShardPlaceCounter() <= gameBrain.getShardPattern().count)
            {
                self.shardToPlay = gameBrain.getShardPattern()[gameBrain.getShardPlaceCounter()]
                switch shardToPlay
                {
                case 1:
                    button1.highlighted = true
                case 2:
                    button2.highlighted = true
                case 3:
                    button3.highlighted = true
                case 4:
                    button4.highlighted = true
                case 5:
                    button5.highlighted = true
                default:
                    print("no button was toggled")
                }
                
                musicBrain.playShard(gameBrain.getShardPattern()[gameBrain.getShardPlaceCounter()])
                
                self.playShardTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "playShardTimerFunction", userInfo: nil, repeats: false)
                gameBrain.addToShardPlaceCounter()
                if (gameBrain.getShardPlaceCounter() == gameBrain.getShardPattern().count)
                {
                    self.view.userInteractionEnabled = true
                    gameBrain.resetShardPlaceCounter()
                    self.waitABeat = true
                    self.playShardPatternTimer.invalidate()
                }
                //            else if (gameBrain.getShardPlaceCounter() < gameBrain.getShardPattern().count)
                //            {
                //                self.view.userInteractionEnabled = true
                //            }
            }
            else
            {
                print("getShardPlaceCounter is out of bounds")
            }
        }
        
        
    }
    
    func playShardTimerFunction()
    {
        playShardTimercounter++
        print("playShardTimercounter: ", playShardTimercounter)
        
        switch shardToPlay
        {
        case 1:
            button1.highlighted = false
        case 2:
            button2.highlighted = false
        case 3:
            button3.highlighted = false
        case 4:
            button4.highlighted = false
        case 5:
            button5.highlighted = false
        default:
            print("no button was toggled")
        }
        
    }

    
    
    //Automatic Functions
    private func startNewGame()
    {
        gameBrain.resetPattern()
        self.waitABeat = true
        self.endShardTimerBool = false
        self.playShardPatternTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "playShardPatternTimerFunction", userInfo: nil, repeats: true)
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



//    func shardSelectTimer()
//    {
//        var touchedShard: Int = shardPattern[shardPlaceCounter]
//        if(endShardTimerBool == true)
//        {
//            endShardTimerBool = false
//            switch touchedShard
//            {
//            case 1:
//                button1.highlighted = true
//            case 2:
//                button2.highlighted = true
//            case 3:
//                button2.highlighted = true
//            case 4:
//                button2.highlighted = true
//            case 5:
//                button2.highlighted = true
//            default:
//                print("no button was toggled")
//            }
//        }
//        else
//        {
//            switch touchedShard
//            {
//            case 1:
//                button1.highlighted = false
//            case 2:
//                button2.highlighted = false
//            case 3:
//                button2.highlighted = false
//            case 4:
//                button2.highlighted = false
//            case 5:
//                button2.highlighted = false
//            default:
//                print("no button was toggled")
//            }
//            shardTimer.invalidate()
//        }
//    }
//
//    func runTimedCode()
//    {
//        if self.pauseTimer == true
//        {
//
//        }else if self.pauseTimer == false
//        {
//            if self.waitABeat == true
//            {
//                self.waitABeat = false
//            }else if self.waitABeat == false
//            {
//                if self.waitForUser == false && self.shardPlaceCounter <= self.shardPattern.count
//                {
//                    self.waitABeat = false
//                    if self.shardPlaceCounter < self.shardPattern.count
//                    {
//                        shardTimer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "shardSelectTimer", userInfo: nil, repeats: true)
//
////                        self.toggleShardStateOff(self.shardPattern[self.shardPlaceCounter - 1])  //this is a problem
//                        play.playShard(self.shardPattern[self.shardPlaceCounter])
////                        self.toggleShardStateOn(self.shardPattern[self.shardPlaceCounter])
//                        self.shardPlaceCounter++
//                    }else if self.shardPlaceCounter == self.shardPattern.count
//                    {
//                        gameBrain.addToPatern()
//                        self.shardPattern = gameBrain.getDynamicPattern()
//                        play.playShard(self.shardPattern[self.shardPlaceCounter])
//                        self.shardPlaceCounter = 0
//                        self.waitForUser = true
//                        self.waitABeat = true
//                        self.view.userInteractionEnabled = true
//                    }else
//                    {
//                        print("your shardPlaceCounter is out of it's bounds")
//                    }
//                }
//            }
//
//        }
//    }
//
//    private func toggleShardStateOn(touchedShard: Int)
//    {
//        switch touchedShard
//        {
//        case 1:
//            button1.highlighted = true
//        case 2:
//            button2.highlighted = true
//        case 3:
//            button2.highlighted = true
//        case 4:
//            button2.highlighted = true
//        case 5:
//            button2.highlighted = true
//        default:
//            print("no button was toggled")
//        }
//    }
//
//    private func toggleShardStateOff(touchedShard: Int)
//    {
//        switch touchedShard
//        {
//        case 1:
//            button1.highlighted = false
//        case 2:
//            button2.highlighted = false
//        case 3:
//            button2.highlighted = false
//        case 4:
//            button2.highlighted = false
//        case 5:
//            button2.highlighted = false
//        default:
//            print("no button was toggled")
//        }
//    }

//    private func resetGameBrainPatternSettings()  //to be moved to gamebrain
//    {
//        self.pauseTimer = true
//        self.waitABeat = true
//        self.shardPlaceCounter = 0
//        self.shardPattern = []
//        self.gameBrain.resetPattern()
//        self.shardPattern = self.gameBrain.getDynamicPattern()
//        gameBrain.resetPattern()
//    }