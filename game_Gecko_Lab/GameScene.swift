//
//  GameScene.swift
//  game_Gecko_Lab
//
//  Created by Krystian Kulawiak on 05.05.2017.
//  Copyright © 2017 Krystian Kulawiak. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var monkey:SKSpriteNode?
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "b1")
        self.addChild(background)
        background.size = CGSize(width: 750, height: 1334)//set width and height background and possiton x,y,z
        background.position=CGPoint(x: self.frame.midX, y: self.frame.midY)
        background.zPosition = 0
        
        let floorImage = SKSpriteNode(imageNamed: "b4")
        floorImage.size = CGSize(width: 750, height: 640)
        floorImage.position=CGPoint(x: self.frame.midX, y: -346)
        floorImage.zPosition = 0.001
        self.addChild(floorImage)
        
        let floorPhysics = SKNode()
        floorPhysics.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: self.frame.minX, y: -504), to: CGPoint(x: self.frame.maxX, y: -504))
        self.addChild(floorPhysics)
        
        let leftMarginesPhysics = SKNode()
        leftMarginesPhysics.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: self.frame.minX , y: self.frame.minY), to: CGPoint(x: self.frame.minX, y: self.frame.maxY))
        self.addChild(leftMarginesPhysics)
        
        let rigtMarginesPhysics = SKNode ()
        rigtMarginesPhysics.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: self.frame.maxX, y: self.frame.minY), to: CGPoint(x: self.frame.maxX, y: self.frame.maxY))
        self.addChild(rigtMarginesPhysics)
            
        
        monkey = SKSpriteNode(imageNamed: "left_2")
        monkey?.position = CGPoint(x: 305, y: -470)
        monkey?.zPosition = 0.01
        self.addChild((monkey)!)
        monkey?.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        
    }
    
}
