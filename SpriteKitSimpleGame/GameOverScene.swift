//
//  GameOverScene.swift
//  SpriteKitSimpleGame
//
//  Created by Main Account on 9/30/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import Foundation
import SpriteKit
import iAd

class GameOverScene: SKScene {
    var button: SKNode! = nil
   var UIiAd: ADBannerView = ADBannerView()
    
    override func didMoveToView(view: SKView) {
        // Create a simple red rectangle that's 100x44
        button = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 999, height: 44))
        // Put it in the center of the scene
        button.position = CGPoint(x: 0, y:CGRectGetMidY(self.frame));
        
        self.addChild(button)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        // Loop over all the touches in this event
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            if button.containsPoint(location) {
                println("tapped!")
                let reveal = SKTransition.flipHorizontalWithDuration(0.5)
                let scene = GameScene(size: size)
                self.view?.presentScene(scene, transition:reveal)
                 UIiAd.alpha = 0

            }
        }
    }
    func appdelegate() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as AppDelegate
    }
  init(size: CGSize, won:Bool) {
    
    super.init(size: size)
    UIiAd = self.appdelegate().UIiAd
    UIiAd.alpha = 1
    
    // 1
    backgroundColor = SKColor.whiteColor()
    
    // 2
    var message = won ? "You Won!" : "You Lose =]]"
    
    // 3
    let label = SKLabelNode(fontNamed: "Chalkduster")
    label.text = message
    label.fontSize = 40
    label.fontColor = SKColor.blackColor()
    label.position = CGPoint(x: size.width/2, y: size.height/2 + 50)
    addChild(label)
    
    let label2 = SKLabelNode(fontNamed: "Chalkduster")
    label2.text = "Play again"
    label2.fontSize = 20
    label2.fontColor = SKColor.whiteColor()
    label2.position = CGPoint(x: size.width/2, y: size.height/2 - 5)
    addChild(label2)

    
    // 4
//    runAction(SKAction.sequence([
//      SKAction.waitForDuration(3.0),
//      SKAction.runBlock() {
//        // 5
//        let reveal = SKTransition.flipHorizontalWithDuration(0.5)
//        let scene = GameScene(size: size)
//        self.view?.presentScene(scene, transition:reveal)
//      }
//    ]))
    
  }

  // 6
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}