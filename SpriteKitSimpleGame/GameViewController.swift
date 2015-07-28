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

class GameViewController: UIViewController, ADBannerViewDelegate,GADBannerViewDelegate, SwiftrisDelegate{
    var UIiAd: ADBannerView = ADBannerView()
    var bannerView:GADBannerView?
     var interstitial: GADInterstitial!
    var SH = UIScreen.mainScreen().bounds.height
    var BV: CGFloat = 0
    
    let statusbarHeight:CGFloat = 20.0
    var adViewHeight:CGFloat = 0
    var bannerDisplayed = false
    
     
    @IBOutlet weak var UDIDlb: UILabel!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var StartButton: UIButton!
    
    @IBOutlet weak var topView: UIView!
    
    @IBAction func MoreGameDrag(sender: AnyObject) {
          topView.hidden = false
        
        //admob banner
        //    if IS_IPAD {
        //        bannerView = GADBannerView(adSize: kGADAdSizeLeaderboard)
        //    } else {
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        //}
        bannerView?.adUnitID = "ca-app-pub-6627251093546168/7268969538"
        bannerView?.delegate = self
        bannerView?.rootViewController = self
        self.view.addSubview(bannerView!)
        adViewHeight = bannerView!.frame.size.height
        bannerView?.loadRequest(GADRequest())
        bannerView?.hidden = true
    }
    
    
    @IBAction func PhuongNguyenDrap(sender: AnyObject) {
        
        let dev = UIDevice.currentDevice().identifierForVendor.UUIDString
        
        UDIDlb.text = dev
        bannerView?.hidden = false
        
    }
    
    @IBAction func MoreGameClick(sender: AnyObject) {
        var barsLink : String = "itms-apps://itunes.apple.com/us/artist/phuong-thanh-nguyen/id1019089261"
        UIApplication.sharedApplication().openURL(NSURL(string: barsLink)!)

    }
    
    @IBAction func showAdClick(sender: AnyObject) {
        
        if (self.interstitial.isReady)
        {
            self.interstitial.presentFromRootViewController(self)
            self.interstitial =   self.appdelegate().createAndLoadAd()
        }
        
        
        let dev = UIDevice.currentDevice().identifierForVendor.UUIDString
        println(dev)
    }
    @IBAction func StartClick(sender: AnyObject) {
        self.startView!.hidden = true
        bannerView?.hidden = true
        //var size = CGSizeMake(100,100)
        //let scene = GameScene(size: size)
        let scene = GameScene(size: view.bounds.size)
        
        let skView = view as SKView
        
//        skView.showsFPS = true
//        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        scene.delegate2 = self
        skView.presentScene(scene)
         UIiAd.alpha = 0
    }
    
   
//    
//    func createAndLoadAd() -> GADInterstitial
//    {
//        var ad = GADInterstitial(adUnitID: "ca-app-pub-6627251093546168/2847273136")
//        
//        var request = GADRequest()
//        
//        request.testDevices = [""]
//        UDIDlb.text = request.testDevices[0].description
//        ad.loadRequest(request)
//        
//        return ad
//    }
    
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
    
    UDIDlb.text = ""
    
    var interstitial = self.appdelegate().interstitial// self.createAndLoadAd()
    
    topView.hidden = true
    
    showAdd()
    UIiAd.alpha = 0
    
    

    
    
  }
    
    func gameStart()
    {
        //bannerView!.hidden = true
         println("game start")
    }
     func gameOver()
     {
//        bannerView!.hidden = false
//        if (self.interstitial.isReady)
//        {
//            self.interstitial.presentFromRootViewController(self)
//            self.interstitial = self.createAndLoadAd()
//        }
        println("game over")
    }
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
                //set admob
        
        UIiAd.alpha = 1
        UIiAd.frame = CGRectMake(0, SH - BV, 0, 0)
        self.view.addSubview(UIiAd)
        UIiAd.delegate = self
        println("khoi tao ")
    }
    func showAdd2()
    {
        //BV = UIiAd.bounds.height
        UIiAd = self.appdelegate().UIiAd
        //set admob
        
        UIiAd.alpha = 1
        //UIiAd.frame = CGRectMake(0, SH - BV, 0, 0)
      
                println("hien lai")
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
        UIiAd.alpha = 1
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
    //GADBannerViewDelegate
    func adViewDidReceiveAd(view: GADBannerView!) {
        println("adViewDidReceiveAd:\(view)");
        self.bannerDisplayed = true
       //relayoutViews()
    }
    
    func adView(view: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        println("\(view) error:\(error)")
        self.bannerDisplayed = false
        //relayoutViews()
    }
    
    func adViewWillPresentScreen(adView: GADBannerView!) {
        println("adViewWillPresentScreen:\(adView)")
        self.bannerDisplayed = false
        //relayoutViews()
    }
    
    func adViewWillLeaveApplication(adView: GADBannerView!) {
        println("adViewWillLeaveApplication:\(adView)")
        self.bannerDisplayed = false
        //relayoutViews()
    }
    
    func adViewWillDismissScreen(adView: GADBannerView!) {
        println("adViewWillDismissScreen:\(adView)")
        self.bannerDisplayed = false
       // relayoutViews()
    }

   
}
