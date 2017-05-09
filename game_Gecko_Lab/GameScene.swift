//
//  GameScene.swift
//  game_Gecko_Lab
//
//  Created by Krystian Kulawiak on 05.05.2017.
//  Copyright © 2017 Krystian Kulawiak. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var monkey:SKSpriteNode?
    var step:SKSpriteNode?
    var left:SKSpriteNode?
    var right:SKSpriteNode?
    var info = true
    
    
    
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
        
        left = SKSpriteNode()
        left?.size = CGSize(width: 350, height: 350)
        left?.anchorPoint = CGPoint(x: 0, y: 0)
        left?.zPosition = 0.01
        left?.position = CGPoint(x: self.frame.minX, y: self.frame.minY)
        self.addChild(left!)
        right = SKSpriteNode()
        right?.size = CGSize(width: 350, height: 350)
        right?.anchorPoint = CGPoint(x: 1, y: 0)
        right?.zPosition = 0.01
        right?.position = CGPoint(x: self.frame.maxX, y: self.frame.minY)
        self.addChild(right!)
        
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
        monkey?.position = CGPoint(x: 305, y: -370)
        monkey?.zPosition = 0.01
        self.addChild(monkey!)
        monkey?.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -10)
        
        monkey?.physicsBody?.categoryBitMask = 2
        
        monkey?.physicsBody?.contactTestBitMask = 1
        
        monkey?.physicsBody?.collisionBitMask = 1
        monkey?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        //self.physicsWorld.contactDelegate = self
        
        
        setupStep()
        
    }
    
    func setupStep(){
        step = SKSpriteNode(imageNamed: "b5")
        step?.size = CGSize(width: 350, height: 60)
        step?.position = CGPoint(x: 305, y: -270)
        step?.anchorPoint = CGPoint(x: 0.5, y: 1.25)
        step?.zPosition = 0.001
        self.addChild(step!)
        step?.physicsBody = SKPhysicsBody(texture: step!.texture!, size: step!.size)
        step?.physicsBody?.isDynamic = false
        
        
    }
    func didBegin(_ contact: SKPhysicsContact) {
        self.physicsWorld.speed = 0.1
        step?.removeAllActions()
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            if touchedNode == monkey {
                monkey?.run(SKAction.moveBy(x: 0, y: 50, duration: 0.1))
                monkey?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                possitionStep()
            }
            if touchedNode == left {
                monkey?.run(SKAction.group([actionMonkeyLeft(),wait(),moveLeft()]))
                monkey?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                possitionStep()
                
            }
            if touchedNode == right {
                monkey?.run(SKAction.group([actionMonkeyRight(),wait(),moveRight()]))
                monkey?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                possitionStep()
                
            }
            
            
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            if touchedNode == left {
                if self.info == true{
                    monkey?.run(SKAction.group([actionMonkeyLeft(),wait(),moveLeft()]))
                    monkey?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    possitionStep()
                    self.info = false
                }else{
                    monkey?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    possitionStep()
                }
            }
            if touchedNode == right {
                if self.info == true{
                    monkey?.run(SKAction.group([actionMonkeyRight(),wait(),moveRight()]))
                    monkey?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    possitionStep()
                    self.info = false
                }else{
                    monkey?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    possitionStep()
                }
            }
            if touchedNode == monkey {
                monkey?.run(SKAction.moveBy(x: 0, y: 50, duration: 0.1))
                monkey?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                possitionStep()
            }
            
        }
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.info=true
        monkey?.removeAllActions()
        monkey?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
    }
    
    func actionMonkeyLeft()->SKAction{
        let action = SKAction.repeatForever(
            SKAction.animate(with: [
                SKTexture(imageNamed: "left_2"),
                SKTexture(imageNamed: "left_1"),
                
                ], timePerFrame: 0.1))
        return action
    }
    
    func actionMonkeyRight()->SKAction{
        let action = SKAction.repeatForever(
            SKAction.animate(with: [
                SKTexture(imageNamed: "right_2"),
                SKTexture(imageNamed: "right_1"),
                
                ], timePerFrame: 0.1))
        return action
    }
    
    func moveLeft()->SKAction{
        let moveNodeUp = SKAction.repeatForever(SKAction.moveBy(x: -20.0, y: 0.0, duration: 0.1))
        return moveNodeUp
    }
    
    func moveRight()->SKAction{
        let moveNodeUp = SKAction.repeatForever(SKAction.moveBy(x: 20.0, y: 0.0, duration: 0.1))
        return moveNodeUp
    }
    
    func wait()->SKAction{
        let wait = SKAction.wait(forDuration: 0.1)
        return wait
    }
    func possitionStep(){
        let position = self.convert((step?.position)!, to: self)
        let position2 = self.convert((monkey?.position)!, to: self)
        if position2.y < position.y{
            step?.physicsBody?.categoryBitMask = 2
            step?.physicsBody?.contactTestBitMask = 1
            step?.physicsBody?.collisionBitMask = 1
        }else{
            step?.physicsBody?.categoryBitMask = 1
            step?.physicsBody?.contactTestBitMask = 2
            step?.physicsBody?.collisionBitMask = 2
        }
        
    }
    
    
}
