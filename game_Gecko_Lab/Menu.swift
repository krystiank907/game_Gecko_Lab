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
        //add background to Scene
        let background = SKSpriteNode(imageNamed: "b1")
        self.addChild(background)
        background.size = CGSize(width: 750, height: 1334)//set width and height background and possiton x,y,z
        background.position=CGPoint(x: self.frame.midX, y: self.frame.midY)
        background.zPosition = 0
        
        let start = SKSpriteNode(imageNamed: "Start")
        start.name = "Start"
        start.position=CGPoint(x: self.frame.midX, y: self.frame.midY)
        start.zPosition = 0.01
        self.addChild(start)
        
        
        //add helloLabel to Scene
        let helloLabel = SKLabelNode(fontNamed: "Helvetica Neue Light Italic")
        self.addChild(helloLabel)
        helloLabel.text = "Hello in Monkey Game"          //set text, font, possiton x,y,z
        helloLabel.fontSize = 69
        helloLabel.position = CGPoint(x: 0, y: 400)
        helloLabel.alpha = 0.0
        helloLabel.run(SKAction.fadeIn(withDuration: 4.0)) //run animation
        helloLabel.zPosition = 0.01
        
        
        let startLabel = SKLabelNode(fontNamed: "Helvetica Neue Light Italic")
        self.addChild(startLabel)
        startLabel.text = "Press start to play"
        startLabel.fontSize = 59
        startLabel.position = CGPoint(x: 0, y: 210)
        startLabel.alpha = 0.0
        startLabel.run(SKAction.fadeIn(withDuration: 4.0))
        startLabel.zPosition = 0.01
        startLabel.run(pulse())
        
        let actionBanana = SKAction.rotate(byAngle: 90, duration: 20.0) // animation rotate
        let banana = SKSpriteNode(imageNamed: "banana")
        self.addChild(banana)
        banana.position = CGPoint(x: -262.5, y: -504.5)
        banana.zPosition = 0.01
        banana.run(SKAction.repeatForever(actionBanana)) //repeat forever animation in actionBanana (rotate)
        
        
        let banana2 = SKSpriteNode(imageNamed: "banana")
        self.addChild(banana2)
        banana2.position = CGPoint(x: 254.5, y: -504.5)
        banana2.run(SKAction.repeatForever(actionBanana))
        banana2.zPosition = 0.01
        
        
        let monkey = SKSpriteNode(imageNamed: "left_1")
        self.addChild(monkey)
        monkey.position = CGPoint(x: self.frame.midX, y: -504.5)
        monkey.zPosition = 0.01
        
        //this animation changed image
        let actionMonkey = SKAction.repeatForever(
            SKAction.animate(with: [
                
                SKTexture(imageNamed: "left_2"),
                SKTexture(imageNamed: "left_1"),
                
                ], timePerFrame: 0.1)
        )
        
        //run animation
        monkey.run(actionMonkey)
        
        
    }
    func pulse()->SKAction{
        let pulseUp = SKAction.scale(to: 1.5, duration: 0.5)
        let pulseDown = SKAction.scale(to: 1.0, duration: 0.5)
        let pulse = SKAction.sequence([pulseUp, pulseDown])
        let repeatPulse = SKAction.repeatForever(pulse)
        return repeatPulse
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self);
            
            if atPoint(location).name == "Start" {
                if let scene = GameScene(fileNamed: "GameScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: 2));
                }
            }
            
        }
        
    }
    
}
