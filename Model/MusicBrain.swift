//
//  MusicBrain.swift
//  Crystaline Mountain
//
//  Created by Issac Greenfield on 9/6/15.
//  Copyright (c) 2015 Issac Greenfield. All rights reserved.
//

import Foundation
import AVFoundation

public class MusicBrain
{

    private var mySound: SystemSoundID
    
    init()
    {
        self.mySound = 0
    }
    
    public func playShard(shardNumber: Int)
    {
        print("\(shardNumber)")
        let soundURL = NSBundle.mainBundle().URLForResource("\(shardNumber)", withExtension: "wav")
        AudioServicesCreateSystemSoundID(soundURL!, &mySound)
        AudioServicesPlaySystemSound(mySound);
    }
    
    public func playBackground(music: String)
    {
        print("\(music)")
        let soundURL = NSBundle.mainBundle().URLForResource("\(music)", withExtension: "wav")
        AudioServicesCreateSystemSoundID(soundURL!, &mySound)
        AudioServicesPlaySystemSound(mySound);
    }
    
    


}