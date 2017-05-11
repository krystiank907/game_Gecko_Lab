//
//  Banana.swift
//  game_Gecko_Lab
//
//  Created by Krystian Kulawiak on 11.05.2017.
//  Copyright © 2017 Krystian Kulawiak. All rights reserved.
//

import SpriteKit


class Banana {
    
    private var minX = CGFloat(-250), maxX = CGFloat(250)
    private var minX2 = CGFloat(100), maxX2 = CGFloat(250)
    
    var i = 0
    
    func spawnBanana() -> SKSpriteNode {
        
        let item: SKSpriteNode?;
        
            item = SKSpriteNode(imageNamed: "banana")
            item!.name = "Banana"
            item!.zPosition = 0.001
            item!.position = CGPoint(x: 275, y: 900)
            item!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            item!.physicsBody = SKPhysicsBody(circleOfRadius: 30)
            item!.physicsBody?.categoryBitMask = 3
            item!.physicsBody?.contactTestBitMask = 1
            item!.physicsBody?.collisionBitMask = 1
            item!.physicsBody?.isDynamic = true
            
        if i%2 == 0{
            item!.position.x = randomBetweenNumbers(firstNum: minX, secondNum: maxX)
        }
        if i%2 == 1{
            item!.position.x = randomBetweenNumbers(firstNum: minX2, secondNum: maxX2)
        }
        item!.position.y = 1500
        i += 1
        
        
        return item!
    }
    func sequenceStep()->SKAction{
        let sequence = SKAction.sequence([
            SKAction.moveBy(x: 0, y: -1500 , duration: 20),
            SKAction.removeFromParent(),
            ])
        return sequence
    }
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
} // class
