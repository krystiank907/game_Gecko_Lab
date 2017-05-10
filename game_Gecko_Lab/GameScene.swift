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
    var floor:SKSpriteNode?
    var info = true
    var first = true
    var lose:SKLabelNode?
    
    
    
    override func didMove(to view: SKView) {
        
        //add background
        let background = SKSpriteNode(imageNamed: "b1")
        self.addChild(background)
        background.size = CGSize(width: 750, height: 1334)//set width and height background and possiton x,y,z
        background.position=CGPoint(x: self.frame.midX, y: self.frame.midY)
        background.zPosition = 0
        
        setupFloor()//add floor
        
        //add button move to left
        left = SKSpriteNode()
        left?.size = CGSize(width: 350, height: 350)
        left?.anchorPoint = CGPoint(x: 0, y: 0)
        left?.zPosition = 0.01
        left?.position = CGPoint(x: self.frame.minX, y: self.frame.minY)
        self.addChild(left!)
        
        //button move to right
        right = SKSpriteNode()
        right?.size = CGSize(width: 350, height: 350)
        right?.anchorPoint = CGPoint(x: 1, y: 0)
        right?.zPosition = 0.01
        right?.position = CGPoint(x: self.frame.maxX, y: self.frame.minY)
        self.addChild(right!)
        
        //add left Physics margines of scene
        let leftMarginesPhysics = SKNode()
        leftMarginesPhysics.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: self.frame.minX , y: self.frame.minY), to: CGPoint(x: self.frame.minX, y: self.frame.maxY))
        self.addChild(leftMarginesPhysics)
        
        //add right Physics margines of scene
        let rigtMarginesPhysics = SKNode ()
        rigtMarginesPhysics.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: self.frame.maxX, y: self.frame.minY), to: CGPoint(x: self.frame.maxX, y: self.frame.maxY))
        self.addChild(rigtMarginesPhysics)
        
        //install monkey on start position
        setupMonkey()
        
        //setup gravity of game world
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        
        //setup bitmask monkey
        monkey?.physicsBody?.categoryBitMask = 2
        monkey?.physicsBody?.contactTestBitMask = 1
        monkey?.physicsBody?.collisionBitMask = 1
        
        setupStep()//add step
        
        //add loseLabel
        lose = SKLabelNode(fontNamed: "Helvetica Neue Light Italic")
        lose?.text = "Lose"
        lose?.fontSize = 90
        lose?.zPosition = 0.01
        lose?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        lose?.run(pulse())
        self.addChild(lose!)
        
    }
    
    func setupMonkey(){
        monkey = SKSpriteNode(imageNamed: "left_2")
        monkey?.position = CGPoint(x: 305, y: -170)
        monkey?.zPosition = 0.01
        monkey?.physicsBody?.allowsRotation = false
        monkey?.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        self.addChild(monkey!)
    }
    
    func setupFloor(){
        floor = SKSpriteNode(imageNamed: "b5")
        floor?.size = CGSize(width: 750, height: 350)
        floor?.anchorPoint = CGPoint(x: 0.5, y: 0.60)
        floor?.position=CGPoint(x: self.frame.midX, y: self.frame.minY)
        floor?.zPosition = 0.001
        self.addChild(floor!)
        floor?.physicsBody = SKPhysicsBody(texture: floor!.texture!, size: floor!.size)
        floor?.physicsBody?.isDynamic = false
        floor?.physicsBody?.categoryBitMask = 1
        floor?.physicsBody?.contactTestBitMask = 2
        floor?.physicsBody?.collisionBitMask = 2
        floor?.run(SKAction.moveBy(x: 0, y: -300 , duration: 15.5))
        
    }
    
    func setupStep(){
        let minX = self.frame.minX
        let maxX = self.frame.maxX
        let minY = self.frame.minY
        let maxY = self.frame.maxY
        let resultX = CGFloat(arc4random_uniform(UInt32(maxX - minX + 1))) + minX
        let resultY = CGFloat(arc4random_uniform(UInt32(maxY - minY + 1))) + minY
        step = SKSpriteNode(imageNamed: "b5")
        step?.size = CGSize(width: 350, height: 60)
        step?.position = CGPoint(x: resultX, y: resultY)
        step?.anchorPoint = CGPoint(x: 0.5, y: 1.25)
        step?.zPosition = 0.001
        self.addChild(step!)
        step?.physicsBody = SKPhysicsBody(texture: step!.texture!, size: step!.size)
        step?.physicsBody?.isDynamic = false
        
    }
    
    //single touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            if touchedNode == monkey {
                monkey?.run(SKAction.moveBy(x: 0, y: 150, duration: 0.1))
                monkey?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                possitionStep()
                left?.isUserInteractionEnabled = true
                right?.isUserInteractionEnabled = true
            }
            if touchedNode == left {
                monkey?.run(SKAction.group([actionMonkeyLeft(),wait(),moveLeft()]))
                monkey?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                possitionStep()
                right?.isUserInteractionEnabled = true
                monkey?.isUserInteractionEnabled = true
                
            }
            if touchedNode == right {
                monkey?.run(SKAction.group([actionMonkeyRight(),wait(),moveRight()]))
                monkey?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                possitionStep()
                left?.isUserInteractionEnabled = true
                monkey?.isUserInteractionEnabled = true
                
            }
            
            
        }
    }
    
    //hold touch
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
                    monkey?.isUserInteractionEnabled = true
                    right?.isUserInteractionEnabled = true
                }else{
                    monkey?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    possitionStep()
                    monkey?.isUserInteractionEnabled = true
                    right?.isUserInteractionEnabled = true
                }
            }
            if touchedNode == right {
                if self.info == true{
                    monkey?.run(SKAction.group([actionMonkeyRight(),wait(),moveRight()]))
                    monkey?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    possitionStep()
                    self.info = false
                    left?.isUserInteractionEnabled = true
                    monkey?.isUserInteractionEnabled = true
                }else{
                    monkey?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    possitionStep()
                    left?.isUserInteractionEnabled = true
                    monkey?.isUserInteractionEnabled = true
                }
            }
            
        }
        
    }
    
    //finish touches
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.info=true
        monkey?.removeAllActions()
        monkey?.physicsBody?.allowsRotation = false
        turnOnInteraction()
    }
    
    //animation for left move monkey
    func actionMonkeyLeft()->SKAction{
        let action = SKAction.repeatForever(
            SKAction.animate(with: [
                SKTexture(imageNamed: "left_2"),
                SKTexture(imageNamed: "left_1"),
                
                ], timePerFrame: 0.1))
        return action
    }
    
    //animation for right move monkey
    func actionMonkeyRight()->SKAction{
        let action = SKAction.repeatForever(
            SKAction.animate(with: [
                SKTexture(imageNamed: "right_2"),
                SKTexture(imageNamed: "right_1"),
                
                ], timePerFrame: 0.1))
        return action
    }
    
    //move monkey left
    func moveLeft()->SKAction{
        let moveNodeUp = SKAction.repeatForever(SKAction.moveBy(x: -20.0, y: -5.0, duration: 0.1))
        return moveNodeUp
    }
    
    //move monkey right
    func moveRight()->SKAction{
        let moveNodeUp = SKAction.repeatForever(SKAction.moveBy(x: 20.0, y: -5.0, duration: 0.1))
        return moveNodeUp
    }
    
    //wait
    func wait()->SKAction{
        let wait = SKAction.wait(forDuration: 0.1)
        return wait
    }
    
    //set BitMask for step
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
    
    //turn on interaction for monkey and button
    func turnOnInteraction(){
        monkey?.isUserInteractionEnabled = false
        right?.isUserInteractionEnabled = false
        left?.isUserInteractionEnabled = false
        
    }
    
    //pulse animation for LoseLabel
    func pulse()->SKAction{
        let pulseUp = SKAction.scale(to: 1.5, duration: 0.5)
        let pulseDown = SKAction.scale(to: 1.0, duration: 0.5)
        let pulse = SKAction.sequence([pulseUp, pulseDown])
        let repeatPulse = SKAction.repeatForever(pulse)
        return repeatPulse
    }
    
    func restart(){
        floor?.removeFromParent()
        step?.removeFromParent()
        monkey?.removeFromParent()
        setupStep()
        setupFloor()
        setupMonkey()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        self.physicsWorld.speed = 0.0
        step?.removeAllActions()
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        let position = self.convert((monkey?.position)!, to: self)
        print(position.y)
        monkey?.physicsBody?.allowsRotation = false
        if position.y > -730 && first == false{
            lose?.run(SKAction.fadeOut(withDuration: 1.0))
        }
        if position.y > -730 && first == true{
            lose?.run(SKAction.fadeOut(withDuration: 0.01))
            first = false
        }
        if position.y < -735{
            lose?.run(SKAction.fadeIn(withDuration: 0.01))
            restart()
            
        }
    }
    
    
}
