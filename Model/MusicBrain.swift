//
//  MusicBrain.swift
//  Crystaline Mountain
//
//  Created by Issac Greenfield on 9/6/15.
//  Copyright (c) 2015 Issac Greenfield. All rights reserved.
//

import Foundation
import AVFoundation

/// A sound manager for wav files
public class MusicBrain
{
    private var mySound: SystemSoundID
    
    init()
    {
        self.mySound = 0
    }
    
    public func playShard(shardNumber: Int)
    {
        if let soundURL = NSBundle.mainBundle().URLForResource("\(shardNumber)", withExtension: "wav") {
            var mySound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL, &mySound)
            // Play
            AudioServicesPlaySystemSound(mySound);
        }
    }
    
    public func playBackground(music: String)
    {
        if let soundURL = NSBundle.mainBundle().URLForResource("\(music)", withExtension: "wav") {
            var mySound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL, &mySound)
            // Play
            AudioServicesPlaySystemSound(mySound);
        }
    }

}