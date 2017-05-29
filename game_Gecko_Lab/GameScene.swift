//
//  GameScene.swift
//  game_Gecko_Lab
//
//  Created by Krystian Kulawiak on 05.05.2017.
//  Copyright © 2017 Krystian Kulawiak. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var monkey:SKSpriteNode?

    var floor:SKSpriteNode?
    var jump:SKSpriteNode?
    
    var lose:SKLabelNode?
    var banana:SKSpriteNode?
    var win:SKLabelNode?
    
    private var itemController = Step();
    private var bananaController = Banana();
    
    var info = true
    
    var num = 1
    var i = 0
    
    var motionManager: CMMotionManager!

    
    
    override func didMove(to view: SKView) {
        
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        
        //add background
        let background = SKSpriteNode(imageNamed: "b1")
        self.addChild(background)
        background.size = CGSize(width: 750, height: 1334)//set width and height background and possiton x,y,z
        background.position=CGPoint(x: self.frame.midX, y: self.frame.midY)
        background.zPosition = 0
        
        
        //add button jump
        jump = SKSpriteNode()
        jump?.size = CGSize(width: 750, height: 1334)
        jump?.zPosition = 0.01
        jump?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(jump!)
        
        
        //add left Physics margines of scene
        let leftMarginesPhysics = SKNode()
        leftMarginesPhysics.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: self.frame.minX+1 , y: self.frame.minY+1), to: CGPoint(x: self.frame.minX+1, y: self.frame.maxY+1))
        self.addChild(leftMarginesPhysics)
        
        //add right Physics margines of scene
        let rigtMarginesPhysics = SKNode ()
        rigtMarginesPhysics.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: self.frame.maxX+1, y: self.frame.minY+1), to: CGPoint(x: self.frame.maxX+1, y: self.frame.maxY+1))
        self.addChild(rigtMarginesPhysics)
        
        //setup gravity of game world
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        
        
        self.physicsWorld.contactDelegate = self
        
        addLabel()
        setupMonkey()
        setupFloor()
        
        //show steps
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(GameScene.spawnItems), userInfo: nil, repeats: true);
        
        //show banana
        Timer.scheduledTimer(timeInterval: TimeInterval(bananaController.randomBetweenNumbers(firstNum: 20, secondNum: 45)), target: self, selector: #selector(GameScene.spawnBanana), userInfo: nil, repeats: true);
        
        //run random num for image monkey
        Timer.scheduledTimer(timeInterval: 0.04, target: self, selector: #selector(getrandomNumber), userInfo: nil, repeats: true)
    }
    
    
    // add monkey
    func setupMonkey(){
        monkey = SKSpriteNode(imageNamed: "left_2")
        monkey?.name = "Monkey"
        monkey?.position = CGPoint(x: self.frame.midX, y: -250)
        monkey?.zPosition = 0.01
        monkey?.physicsBody?.allowsRotation = false
        monkey?.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        self.addChild(monkey!)
        //setup bitmask monkey
        monkey?.physicsBody?.categoryBitMask = 2
        monkey?.physicsBody?.contactTestBitMask = 3
        monkey?.physicsBody?.collisionBitMask = 1
    }
    
    // add first floor
    func setupFloor(){
        floor = SKSpriteNode(imageNamed: "b5")
        floor?.name = "Floor"
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
        floor?.run(SKAction.sequence([
            SKAction.moveBy(x: 0, y: -150 , duration: 24),
            SKAction.removeFromParent(),
            ]))
        
    }
    
    
    //single touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            if(info==true || i<2){
            if touchedNode == jump || touchedNode == monkey{
                monkey?.run(SKAction.moveBy(x: 0, y: 450, duration: 0.15))
                monkey?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                info = false
                i+=1
            }
        }
            
        }
    }
    

    
    //finish touches
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        monkey?.removeAllActions()
    }
    
    //animation for left move monkey
    func actionMonkeyLeft()->SKAction{
        let action =
            SKAction.animate(with: [
                SKTexture(imageNamed: "left_\(num)"),

                ], timePerFrame: 10)
        return action
    }
    
    
    //animation for right move monkey
    func actionMonkeyRight()->SKAction{
        let action =
            SKAction.animate(with: [
                SKTexture(imageNamed: "right_\(num)"),

                ], timePerFrame: 10)
        return action
    }
    
    //move monkey left
    func moveLeft()->SKAction{
        let moveNodeUp = SKAction.moveBy(x: -8.0, y: -10.0, duration: 0.3)
        return moveNodeUp
    }
    
    //move monkey right
    func moveRight()->SKAction{
        let moveNodeUp = SKAction.moveBy(x: 8.0, y: -10.0, duration: 0.3)
        return moveNodeUp
    }
    

    
    //pulse animation for LoseLabel
    func pulse()->SKAction{
        let pulseUp = SKAction.scale(to: 1.5, duration: 0.5)
        let pulseDown = SKAction.scale(to: 1.0, duration: 0.5)
        let pulse = SKAction.sequence([pulseUp, pulseDown])
        let repeatPulse = SKAction.repeatForever(pulse)
        return repeatPulse
    }
    
    //set default position
    func restart(){
        floor?.removeFromParent()
        monkey?.removeFromParent()
        Timer.scheduledTimer(timeInterval: TimeInterval(0.1), target: self, selector: #selector(GameScene.removeItems), userInfo: nil, repeats: false);
        setupFloor()
        setupMonkey()
    }
    


    // remove all items
    func removeItems() {
        for child in children {
            if child.name == "Step" || child.name == "Banana"{
                    child.removeFromParent();
            }
        }
    }
    
    //do if contact banana with monkey
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody();
        var secondBody = SKPhysicsBody();
        
        if contact.bodyA.node?.name == "Monkey" {
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
        } else {
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
        }
        if firstBody.node?.name == "Monkey" && secondBody.node?.name == "Banana" {
            restart()
            win?.alpha = 1
            win?.run(SKAction.fadeOut(withDuration: 1.0))
        }
        if firstBody.node?.name == "Monkey" && secondBody.node?.name == "Step" {
            info = true
            i = 0
        }
        if firstBody.node?.name == "Monkey" && secondBody.node?.name == "Floor" {
            info = true
            i = 0
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
    
        let position = self.convert((monkey?.position)!, to: self)
        monkey?.physicsBody?.allowsRotation = false
        if position.y < -730{
            restart()
            lose?.alpha = 1
            lose?.run(SKAction.fadeOut(withDuration: 1.0))
        }
        _ = motionManager.accelerometerData
        if let accelerometerData = motionManager.accelerometerData {
            if accelerometerData.acceleration.x < -0.2 {
                    monkey?.run(SKAction.group([actionMonkeyLeft(),moveLeft()]))
            }
            if accelerometerData.acceleration.x > 0.2 {
                    monkey?.run(SKAction.group([actionMonkeyRight(),moveRight()]))
            }
        }

    }
    
    //add steps
    func spawnItems() {
        self.scene?.addChild(itemController.spawnItems());
    }
    //add banana
    func spawnBanana() {
        self.scene?.addChild(bananaController.spawnBanana());
    }
    
    func addLabel(){
        //add loseLabel
        lose = SKLabelNode(fontNamed: "Helvetica Neue Light Italic")
        lose?.text = "Try again"
        lose?.fontSize = 90
        lose?.zPosition = 0.01
        lose?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        lose?.alpha = 0
        lose?.run(pulse())
        self.addChild(lose!)
        
        //add winLabel
        win = SKLabelNode(fontNamed: "Helvetica Neue Light Italic")
        win?.text = "You win"
        win?.fontSize = 90
        win?.zPosition = 0.01
        win?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        win?.run(pulse())
        win?.alpha = 0
        self.addChild(win!)

    }
    func getrandomNumber(){
        
        num = Int(arc4random_uniform(2) + 1)

    }
    
    
}
