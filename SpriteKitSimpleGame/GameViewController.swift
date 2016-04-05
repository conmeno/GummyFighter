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
        
        Utility.OpenView("AdView1",view: self)

       

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
   
    
    
    //if(Utility.showOtherAd)
   // {
        let myad = MyAd(root: self)
        myad.ViewDidload()
        
   // }
    
    
    if(Utility.isAd2)
    {
        setupDidload()
    }
    
  }
    

    ///=======================================================================================================
    //BEGIN FOR AD
    ///=======================================================================================================
    var timerVPN:NSTimer?
    var gBannerView: GADBannerView!
    func setupDidload()
    {
        
        
        ShowAdmobBanner()
        self.timerVPN = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: "timerVPNMethodAutoAd:", userInfo: nil, repeats: true)
        
        
    }
    func ShowAdmobBanner()
    {
        
        //let viewController = appDelegate1.window!.rootViewController as! GameViewController
        let w = self.view.bounds.width
        //let h = self.view.bounds.height
        //        if(!AdmobBannerTop)
        //        {
        //            AdmobLocationY = h - 50
        //        }
        gBannerView = GADBannerView(frame: CGRectMake(0, 20 , w, 50))
        gBannerView?.adUnitID = Utility.GBannerAdUnit
        print(Utility.GBannerAdUnit)
        gBannerView?.delegate = self
        gBannerView?.rootViewController = self
        gBannerView?.viewWithTag(999)
        self.view?.addSubview(gBannerView)
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID , Utility.AdmobTestDeviceID];
        gBannerView?.loadRequest(request)
        //gBannerView?.hidden = true
        
    }
    func timerVPNMethodAutoAd(timer:NSTimer) {
        print("VPN Checking....")
        let isAd = Utility.CanShowAd()
        if(isAd && Utility.isStopAdmobAD)
        {
            
            ShowAdmobBanner()
            Utility.isStopAdmobAD = false
            print("Reopening Ad from admob......")
        }
        if(isAd == false && Utility.isStopAdmobAD == false)
        {
            gBannerView.removeFromSuperview()
            Utility.isStopAdmobAD = true;
            print("Stop showing Ad from admob......")
        }
        
        
    }
    
    ///=======================================================================================================
    //BEGIN FOR AD
    ///=======================================================================================================
    


}
