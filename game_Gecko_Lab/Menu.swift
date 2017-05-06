//
//  Menu.swift
//  game_Gecko_Lab
//
//  Created by Krystian Kulawiak on 06.05.2017.
//  Copyright © 2017 Krystian Kulawiak. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


class Menu: SKScene {
    


    
    override func didMove(to view: SKView) {

        let background = SKSpriteNode(imageNamed: "b1")
        self.addChild(background)
        background.size = CGSize(width: 750, height: 1334)
        background.position=CGPoint(x: self.frame.midX, y: self.frame.midY)

        
        
        let helloLabel = SKLabelNode(fontNamed: "Helvetica Neue Light Italic")
        self.addChild(helloLabel)
        helloLabel.text = "Hello in Monkey Game"
        helloLabel.fontSize = 69
        helloLabel.position = CGPoint(x: 0, y: 400)
        helloLabel.alpha = 0.0
        helloLabel.run(SKAction.fadeIn(withDuration: 4.0))

        
        let startLabel = SKLabelNode(fontNamed: "Helvetica Neue Light Italic")
        self.addChild(startLabel)
        startLabel.text = "Press start to play"
        startLabel.fontSize = 59
        startLabel.position = CGPoint(x: 0, y: 250)
        startLabel.alpha = 0.0
        startLabel.run(SKAction.fadeIn(withDuration: 4.0))

        let actionBanana = SKAction.rotate(byAngle: 90, duration: 20.0)
        let banana = SKSpriteNode(imageNamed: "banana")
        self.addChild(banana)
        banana.position = CGPoint(x: -262.5, y: -504.5)
        banana.run(SKAction.repeatForever(actionBanana))

        
        let banana2 = SKSpriteNode(imageNamed: "banana")
        self.addChild(banana2)
        banana2.position = CGPoint(x: 254.5, y: -504.5)
        banana2.run(SKAction.repeatForever(actionBanana))
        
        
        let monkey = SKSpriteNode(imageNamed: "left_1")
        self.addChild(monkey)
        monkey.position = CGPoint(x: self.frame.midX, y: -504.5)
        
        let actionMonkey = SKAction.repeatForever(
            SKAction.animate(with: [
                
                SKTexture(imageNamed: "left_2"),
                SKTexture(imageNamed: "left_1"),
                
                ], timePerFrame: 0.1)
        )
        
        
        monkey.run(actionMonkey)

        
        
    

        
        // Get label node from scene and store it for use later
//        self.helloLabel = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let helloLabel = self.helloLabel {
//            helloLabel.alpha = 0.0
//            helloLabel.run(SKAction.fadeIn(withDuration: 4.0))
//            
//        }
//        self.startLabel = self.childNode(withName: "//startLabel") as? SKLabelNode
//        if let startLabel = self.startLabel {
//            startLabel.alpha = 0.0
//            startLabel.run(SKAction.fadeIn(withDuration: 5.0))
//        }

        // Create shape node to use during mouse interaction
       
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }

    
    

    

}
