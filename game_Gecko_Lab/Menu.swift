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
    
    private var helloLabel : SKLabelNode?
    private var startLabel : SKLabelNode?

    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.helloLabel = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let helloLabel = self.helloLabel {
            helloLabel.alpha = 0.0
            helloLabel.run(SKAction.fadeIn(withDuration: 4.0))
            
        }
        self.startLabel = self.childNode(withName: "//startLabel") as? SKLabelNode
        if let startLabel = self.startLabel {
            startLabel.alpha = 0.0
            startLabel.run(SKAction.fadeIn(withDuration: 5.0))
        }

        // Create shape node to use during mouse interaction
       
    }

    

}
