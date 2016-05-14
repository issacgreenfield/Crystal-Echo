//
//  GameBrain.swift
//  Crystaline Mountain
//
//  Created by Issac Greenfield on 9/10/15.
//  Copyright (c) 2015 Issac Greenfield. All rights reserved.
//

import Foundation
import AVFoundation

/// A random pattern generator that checks if user has matched the pattern
class GameBrain
{
    private var shardPattern: [Int]
    private var shardPlaceCounter: Int
    
    init()
    {
        self.shardPattern = [3]
        self.shardPlaceCounter = 0
    }
    
    func addToPatern()
    {
        self.shardPattern.append(Int(arc4random_uniform(5) + 1))
    }
    
    func addToShardPlaceCounter()
    {
        self.shardPlaceCounter++
    }
    
    func getShardPattern() -> [Int]
    {
        return self.shardPattern
    }
    
    func getShardPlaceCounter() -> Int
    {
        return self.shardPlaceCounter
    }
    
    func checkPattern(touchedShard: Int) ->Bool
    {
        if(touchedShard != Int(self.shardPattern[shardPlaceCounter]))
        {
            return false
        }
        return true
    }
    
    func resetPattern()
    {
        self.shardPattern = [3]
        self.shardPlaceCounter = 0
    }
    
    func resetShardPlaceCounter()
    {
        self.shardPlaceCounter = 0
    }
    
    func playExamplePattern() ->[Int]
    {
        let patternExample: [Int] = [1, 3, 2, 5, 4, 2, 4, 5, 2, 1]
        return patternExample
    }
}
