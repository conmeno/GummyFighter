//
//  GameScene.swift
//  SpriteKitSimpleGame
//
//  Created by Main Account on 9/30/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import AVFoundation


var backgroundMusicPlayer: AVAudioPlayer!

func playBackgroundMusic(filename: String) {
  let url = NSBundle.mainBundle().URLForResource(
    filename, withExtension: nil)
  if (url == nil) {
    println("Could not find file: \(filename)")
    return
  }

  var error: NSError? = nil
  backgroundMusicPlayer = 
    AVAudioPlayer(contentsOfURL: url, error: &error)
  if backgroundMusicPlayer == nil {
    println("Could not create audio player: \(error!)")
    return
  }

  backgroundMusicPlayer.numberOfLoops = -1
  backgroundMusicPlayer.prepareToPlay()
  backgroundMusicPlayer.play()
}

import SpriteKit
import iAd

func + (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
func sqrt(a: CGFloat) -> CGFloat {
  return CGFloat(sqrtf(Float(a)))
}
#endif

extension CGPoint {
  func length() -> CGFloat {
    return sqrt(x*x + y*y)
  }
  
  func normalized() -> CGPoint {
    return self / length()
  }
}

struct PhysicsCategory {
  static let None      : UInt32 = 0
  static let All       : UInt32 = UInt32.max
  static let Monster   : UInt32 = 0b1       // 1
  static let Projectile: UInt32 = 0b10      // 2
}

protocol SwiftrisDelegate {
    func gameOver()
    func gameStart()
    
    
}


import iAd
class GameScene: SKScene, SKPhysicsContactDelegate {
  
   var UIiAd: ADBannerView = ADBannerView()
  let player = SKSpriteNode(imageNamed: "player")
  var monstersDestroyed = 0
  var delegate2:SwiftrisDelegate?
  let lbScore = SKLabelNode()
    
    
    func appdelegate() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as AppDelegate
    }
  override func didMoveToView(view: SKView) {
    
    UIiAd = self.appdelegate().UIiAd
    UIiAd.alpha = 0
    
    self.delegate2?.gameStart()
    
    playBackgroundMusic("1.mp3")
    /* Setup your scene here */
    var background : SKSpriteNode = SKSpriteNode (imageNamed: "b1.png")
    background.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
    background.zPosition = 0.0
    background.alpha = 0.5
    self.addChild(background)
  
    //backgroundColor = SKColor.purpleColor()
    player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
    player.zPosition = 0.5
    addChild(player)
    
    physicsWorld.gravity = CGVectorMake(0, 0)
    physicsWorld.contactDelegate = self
    
    addMonster()
    println("Moi")
    //add score
    
    lbScore.text = "0"
    lbScore.fontSize = 25
    lbScore.fontColor = SKColor.whiteColor()
    lbScore.position = CGPoint(x: 10, y: 10)
    addChild(lbScore)
    //end set core
    
    runAction(SKAction.repeatActionForever(
      SKAction.sequence([
        SKAction.runBlock(addMonster),
        SKAction.waitForDuration(1.0)
      ])
    ))
    
  }
  
  func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
  }

  func random(#min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
  }

  func addMonster() {

    // Create sprite
    let monster = SKSpriteNode(imageNamed: "monster")
    monster.physicsBody = SKPhysicsBody(rectangleOfSize: monster.size)
    monster.physicsBody?.dynamic = true
    monster.physicsBody?.categoryBitMask = PhysicsCategory.Monster
    monster.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile
    monster.physicsBody?.collisionBitMask = PhysicsCategory.None
     monster.zPosition = 0.5
    // Determine where to spawn the monster along the Y axis
    let actualY = random(min: monster.size.height/2, max: size.height - monster.size.height/2)
    
    // Position the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    monster.position = CGPoint(x: size.width + monster.size.width/2, y: actualY)
    
    // Add the monster to the scene
    addChild(monster)
    
    // Determine speed of the monster
    let actualDuration = random(min: CGFloat(1.0), max: CGFloat(3.0))
    
    // Create the actions
    let actionMove = SKAction.moveTo(CGPoint(x: -monster.size.width/2, y: actualY), duration: NSTimeInterval(actualDuration))
    let actionMoveDone = SKAction.removeFromParent()
    let loseAction = SKAction.runBlock() {
        

      let reveal = SKTransition.flipHorizontalWithDuration(0.5)
      let gameOverScene = GameOverScene(size: self.size, won: false)
      self.view?.presentScene(gameOverScene, transition: reveal)
    self.delegate2?.gameOver()
    }
    monster.runAction(SKAction.sequence([actionMove, loseAction, actionMoveDone]))

  }
  
  override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {

    runAction(SKAction.playSoundFileNamed("buzz2.mp3", waitForCompletion: false))

    // 1 - Choose one of the touches to work with
    let touch = touches.anyObject() as UITouch
    let touchLocation = touch.locationInNode(self)
    
    // 2 - Set up initial location of projectile
    let projectile = SKSpriteNode(imageNamed: "projectile")
    projectile.position = player.position
    
    projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width/2)
    projectile.physicsBody?.dynamic = true
    projectile.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
    projectile.physicsBody?.contactTestBitMask = PhysicsCategory.Monster
    projectile.physicsBody?.collisionBitMask = PhysicsCategory.None
    projectile.physicsBody?.usesPreciseCollisionDetection = true
    
    // 3 - Determine offset of location to projectile
    let offset = touchLocation - projectile.position
    
    // 4 - Bail out if you are shooting down or backwards
    if (offset.x < 0) { return }
    
    // 5 - OK to add now - you've double checked position
    addChild(projectile)
    
    // 6 - Get the direction of where to shoot
    let direction = offset.normalized()
    
    // 7 - Make it shoot far enough to be guaranteed off screen
    let shootAmount = direction * 1000
    
    // 8 - Add the shoot amount to the current position
    let realDest = shootAmount + projectile.position
    
    // 9 - Create the actions
    let actionMove = SKAction.moveTo(realDest, duration: 2.0)
    let actionMoveDone = SKAction.removeFromParent()
    projectile.runAction(SKAction.sequence([actionMove, actionMoveDone]))
    
  }
  
  func projectileDidCollideWithMonster(projectile:SKSpriteNode, monster:SKSpriteNode) {
    println("Hit")
    projectile.removeFromParent()
    monster.removeFromParent()
    
    monstersDestroyed++
    // delegate2?.gamePoint(monstersDestroyed)
    lbScore.text = String(monstersDestroyed)
    
    if (monstersDestroyed > 100) {
      let reveal = SKTransition.flipHorizontalWithDuration(0.5)
      let gameOverScene = GameOverScene(size: self.size, won: true)
      self.view?.presentScene(gameOverScene, transition: reveal)
    }
    
  }
  
  func didBeginContact(contact: SKPhysicsContact) {

    // 1
    var firstBody: SKPhysicsBody
    var secondBody: SKPhysicsBody
    if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
      firstBody = contact.bodyA
      secondBody = contact.bodyB
    } else {
      firstBody = contact.bodyB
      secondBody = contact.bodyA
    }
    
    // 2
    if ((firstBody.categoryBitMask & PhysicsCategory.Monster != 0) &&
        (secondBody.categoryBitMask & PhysicsCategory.Projectile != 0)) {
      projectileDidCollideWithMonster(firstBody.node as SKSpriteNode, monster: secondBody.node as SKSpriteNode)
    }
    
  }
  
}
