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
    
    private var counter = 1

    @IBAction func buttonPressed(sender: UIButton) {
        print("good job, ikies!")
        print((sender.titleLabel?.text)!)
        self.playSound(Int((sender.titleLabel?.text)!)!)

    }

    private func playButton(button: String)
    {
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("didTimeout"), userInfo: nil, repeats: false)
        self.playSound(Int(button)!)
        
//        switch button
//        {
//        case "1":
//            button1 .selected = true
//            timer.timeInterval
//            button1 .selected = false
//        case "2":
//            button2 .selected = true
//            timer.timeInterval
//            button2 .selected = false
//        case "3":
//            button3 .selected = true
//            timer.timeInterval
//            button3 .selected = false
//        case "4":
//            button4 .selected = true
//            timer.timeInterval
//            button4 .selected = false
//        case "5":
//            button5 .selected = true
//            timer.timeInterval
//            button5 .selected = false
//        default:
//            print("oops")
//        }
        
        timer.invalidate()
    }
    
    private func playSound(buttonNumber: Int)
    {
        let soundURL = NSBundle.mainBundle().URLForResource("\(buttonNumber)", withExtension: "wav")
        var mySound: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundURL!, &mySound)
        AudioServicesPlaySystemSound(mySound);
        
    }

    @IBAction func examplePattern() {


        playSound(1)
        playSound(2)
        
//        gameTimer.invalidate()
    }
    func runTimedCode() {
        if self.counter < 10
        {
            playSound(1)
            self.counter++
        }
    }
    
    override func viewDidLoad() {
        var gameTimer: NSTimer!
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "runTimedCode", userInfo: nil, repeats: true)
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

