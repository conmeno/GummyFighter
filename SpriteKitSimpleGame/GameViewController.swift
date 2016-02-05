//
//  GameViewController.swift
//  SpriteKitSimpleGame
//
//  Created by Main Account on 9/30/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit
import SpriteKit
import GoogleMobileAds
 


class GameViewController: UIViewController, GADBannerViewDelegate {
   //var UIiAd: ADBannerView = ADBannerView()
    var SH = UIScreen.mainScreen().bounds.height
    var BV: CGFloat = 0

    
    //@IBOutlet weak var UDIDlb: UILabel!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var StartButton: UIButton!
    

    
  
    
    
    
    @IBAction func MoreGameDrag(sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "StoryboardAD", bundle: nil)
        
        let WebDetailView = storyboard.instantiateViewControllerWithIdentifier("AdView1") as UIViewController
        
        self.presentViewController(WebDetailView, animated: true, completion: nil)
       

    }
   
    
   

    
    @IBAction func MoreGameClick(sender: AnyObject) {
       //topView.hidden = false
        let barsLink : String = "itms-apps://itunes.apple.com/us/artist/phuong-thanh-nguyen/id1019089261"
        UIApplication.sharedApplication().openURL(NSURL(string: barsLink)!)

    }
    

    

    
    @IBAction func showAdClick(sender: AnyObject) {
        
        //showAds()
    }
 
 
    
    
    @IBAction func StartClick(sender: AnyObject) {
        self.startView!.hidden = true
      
        let scene = GameScene(size: view.bounds.size)
        
        let skView = view as! SKView
        
//        skView.showsFPS = true
//        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
       // scene.delegate2 = self
        skView.presentScene(scene)
       //  UIiAd.alpha = 0
    }
    

    
    func PauseGame()
    {
//        scene.stopTicking()
//        play = 0
//        var image = UIImage(named: "play.png") as UIImage?
//        tapGes.enabled = false
//        PanGes.enabled = false
//        SwipeGes.enabled = false
//        PauseButton.setImage(image, forState: .Normal)
    }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.window?.rootViewController = self
    
   // let rootVC = self.view.window?.rootViewController
     
         
    //CheckAdOptionValue()
   
    
    
    
    let myAd = MyAd(root: self)
    
    myAd.ViewDidload()
    
  }
    

    


}
