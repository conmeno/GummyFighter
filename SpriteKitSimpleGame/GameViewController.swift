//
//  GameViewController.swift
//  SpriteKitSimpleGame
//
//  Created by Main Account on 9/30/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit
import SpriteKit
import iAd
import GoogleMobileAds

class GameViewController: UIViewController, ADBannerViewDelegate,VungleSDKDelegate {
    var UIiAd: ADBannerView = ADBannerView()
    var SH = UIScreen.mainScreen().bounds.height
    var BV: CGFloat = 0
    
    @IBOutlet weak var txtUDID: UITextView!
     var vungleSdk = VungleSDK.sharedSDK()
      var AdNumber = 1
    //@IBOutlet weak var UDIDlb: UILabel!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var StartButton: UIButton!
    
    @IBOutlet weak var topView: UIView!
    
    @IBAction func MoreGameDrag(sender: AnyObject) {
        
        
        let dev = UIDevice.currentDevice().identifierForVendor.UUIDString
        
        txtUDID.text = dev
        topView.hidden = false
    }
    
    
    @IBAction func MoreGameClick(sender: AnyObject) {
       //topView.hidden = false
        var barsLink : String = "itms-apps://itunes.apple.com/us/artist/phuong-thanh-nguyen/id1019089261"
        UIApplication.sharedApplication().openURL(NSURL(string: barsLink)!)

    }
    
    
    @IBAction func AdmobClick(sender: AnyObject) {
        showAdmob()
    }
    
    @IBAction func VungleClick(sender: AnyObject) {
        showVungle()
    }
    
    
    @IBAction func AdcolonyClick(sender: AnyObject) {
        showAdcolony()
    }
    
    @IBAction func RealMoreAppClick(sender: AnyObject) {
        var barsLink : String = "itms-apps://itunes.apple.com/us/artist/phuong-thanh-nguyen/id1019089261"
        UIApplication.sharedApplication().openURL(NSURL(string: barsLink)!)
    }
    
    @IBAction func showAdClick(sender: AnyObject) {
        
        showAds()
    }
    func showAdmob()
    {
        if (self.interstitial.isReady)
        {
            self.interstitial.presentFromRootViewController(self)
            self.interstitial = self.createAndLoadAd()
        }
    }
    func showAds()
    {
        Chartboost.showInterstitial("Home" + String(AdNumber))
        println(AdNumber)
    }
    func showAdcolony()
    {
        AdColony.playVideoAdForZone("vzc1c1b51b68a749f797", withDelegate: nil)
    }
    func showVungle()
    {
        vungleSdk.playAd(self, error: nil)
    }
    
    
    @IBAction func StartClick(sender: AnyObject) {
        self.startView!.hidden = true
        
        //var size = CGSizeMake(100,100)
        //let scene = GameScene(size: size)
        let scene = GameScene(size: view.bounds.size)
        
        let skView = view as SKView
        
//        skView.showsFPS = true
//        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
       // scene.delegate2 = self
        skView.presentScene(scene)
         UIiAd.alpha = 0
    }
    
    var interstitial: GADInterstitial!
    
    func createAndLoadAd() -> GADInterstitial
    {
        var ad = GADInterstitial(adUnitID: "ca-app-pub-6627251093546168/2847273136")
        
        var request = GADRequest()
        
        request.testDevices = [""]
        
        ad.loadRequest(request)
        
        return ad
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
    txtUDID.hidden = false
    topView.hidden = true
     UIiAd.alpha = 0
    self.interstitial = self.createAndLoadAd()
    
    //show chartboost
    Chartboost.showInterstitial("Home")
    //show vungle
    vungleSdk.delegate = self
    vungleSdk.playAd(self, error: nil)
    //adcolony
    AdColony.playVideoAdForZone("vzd576c4633e5544b8aa", withDelegate: nil)

  }
  
//     func gamePoint(point: Int)
//     {
//    
//    lbScore.text = String(point)
//        println(point)
//    }
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
    
    
    //begin iad
    // 1
    func appdelegate() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as AppDelegate
    }
    
    // 2
    override func viewWillAppear(animated: Bool) {
        showAdd()
    }
    func showAdd()
    {
        BV = UIiAd.bounds.height
        UIiAd = self.appdelegate().UIiAd
        UIiAd.alpha = 1
        UIiAd.frame = CGRectMake(0, SH - BV, 0, 0)
        self.view.addSubview(UIiAd)
        UIiAd.delegate = self
        println("khoi tao ")
    }
    
    // 3
    override func viewWillDisappear(animated: Bool) {
        UIiAd.delegate = nil
        UIiAd.removeFromSuperview()
    }
    
    //   bannerViewWillLoadAd
    func bannerViewWillLoadAd(banner: ADBannerView!) {
        println("will load ")
        UIiAd.alpha = 1
    }
    
    
    // 4
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        
        UIiAd.frame = CGRectMake(0, SH + 50, 0, 0)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1)
        //UIiAd.alpha = 1
        UIiAd.frame = CGRectMake(0, SH - 50, 0, 0)
        UIView.commitAnimations()
        println("da load ")
    }
    
    // 5
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0)
        UIiAd.alpha = 1
        UIView.commitAnimations()
        println("fail load ")
        
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        println("ad press ")
        PauseGame()
        return true
    }
    //end iad
    //admob delegate
    
   
}
