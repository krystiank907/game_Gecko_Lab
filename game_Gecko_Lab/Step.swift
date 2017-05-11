//
//  Step.swift
//  game_Gecko_Lab
//
//  Created by Krystian Kulawiak on 11.05.2017.
//  Copyright © 2017 Krystian Kulawiak. All rights reserved.
//


import SpriteKit


class Step {
    
    private var minX1 = CGFloat(-250), maxX1 = CGFloat(-100)
    private var minX2 = CGFloat(100), maxX2 = CGFloat(250)
    
    var i = 0
    
    func spawnItems() -> SKSpriteNode {
        

        let item: SKSpriteNode?;
        
        item = SKSpriteNode(imageNamed: "b5")
        item!.name = "Step"
        item!.size = CGSize(width: 300, height: 60)
        item!.physicsBody = SKPhysicsBody(texture: item!.texture!, size: item!.size)
        item!.physicsBody?.categoryBitMask = 1
        item!.physicsBody?.contactTestBitMask = 2
        item!.physicsBody?.collisionBitMask = 2
        item!.physicsBody?.isDynamic = false
        item!.zPosition = 0.001
        item!.anchorPoint = CGPoint(x: 0.5, y: 1.25)
        if i%2 == 0{
        item!.position.x = randomBetweenNumbers(firstNum: minX1, secondNum: maxX1)
        }
        if i%2 == 1{
        item!.position.x = randomBetweenNumbers(firstNum: minX2, secondNum: maxX2)
        }
        item!.position.y = 750
        item!.run(sequenceStep())
        i += 1
        if i==10 {i=0}
        
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
