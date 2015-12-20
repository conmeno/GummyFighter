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
    
    @IBOutlet weak var txtUDID: UITextView!
     //var vungleSdk = VungleSDK.sharedSDK()
      var AdNumber = 1
    
    var gBannerView: GADBannerView!
    var timerVPN:NSTimer?
    var isStopAD = true
    
    //@IBOutlet weak var UDIDlb: UILabel!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var StartButton: UIButton!
    
    @IBOutlet weak var topView: UIView!
    
    //new funciton
        @IBOutlet weak var AdmobCheck: UISwitch!
    
    @IBOutlet weak var ChartboostCheck: UISwitch!
    
    var isAdmob = true;
    
    var isChart = false
    
    var isShowFullAdmob = false
    var isShowChartboostFirst = false
    var timerAdmobFull:NSTimer?
    @IBOutlet weak var textDevice: UITextView!
    //end new funciton
    
    
    @IBAction func MoreGameDrag(sender: AnyObject) {
        
        
        topView.hidden = false
        
        var myIDFA: String = ""
        // Check if Advertising Tracking is Enabled
        if ASIdentifierManager.sharedManager().advertisingTrackingEnabled {
            // Set the IDFA
            myIDFA = ASIdentifierManager.sharedManager().advertisingIdentifier.UUIDString
        }
        
        let venderID = UIDevice.currentDevice().identifierForVendor!.UUIDString
       
        
        textDevice.text = "IDFA: \n" + myIDFA + "\nVendorID: \n" + venderID
    }
    
    @IBAction func СloseClick(sender: AnyObject) {
         topView.hidden = true
    }
    
     var timerAd:NSTimer?
    @IBAction func closeDrag(sender: AnyObject) {
        topView.backgroundColor = UIColor.blueColor()
        
        
        
        self.timerAd = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "timerMethodAutoAd:", userInfo: nil, repeats: true)
        
    }
    
    func timerMethodAutoAd(timer:NSTimer) {
        println("auto play")
        topView.backgroundColor = UIColor.redColor()
        //        if (AdTapsy.isAdReadyToShow()) {
        //            println("Ad is ready to be shown");
        //            AdTapsy.showInterstitial(self);
        //
        //        } else {
        //            println("Ad is not ready to be shown");
        //        }
        showAds()
        //showAdcolony()
    }

    
    @IBAction func MoreGameClick(sender: AnyObject) {
       //topView.hidden = false
        var barsLink : String = "itms-apps://itunes.apple.com/us/artist/phuong-thanh-nguyen/id1019089261"
        UIApplication.sharedApplication().openURL(NSURL(string: barsLink)!)

    }
    

    
//    @IBAction func AdcolonyClick(sender: AnyObject) {
//       // showAdcolony()
//    }
//    
//    @IBAction func RealMoreAppClick(sender: AnyObject) {
//        var barsLink : String = "itms-apps://itunes.apple.com/us/artist/phuong-thanh-nguyen/id1019089261"
//        UIApplication.sharedApplication().openURL(NSURL(string: barsLink)!)
//    }
    
    @IBAction func showAdClick(sender: AnyObject) {
        
        showAds()
    }
 
    var interstitial: GADInterstitial!
    
    func createAndLoadAd() -> GADInterstitial
    {
        var ad = GADInterstitial(adUnitID: "ca-app-pub-2807486494925046/8605351218")
        
        var request = GADRequest()
        
        request.testDevices = [kGADSimulatorID, "6aa57fc4161001786a1a9e7cea470364"]
        
        ad.loadRequest(request)
        
        return ad
    }
    func showAdmob()
    {
        if (self.interstitial.isReady)
        {
            self.interstitial.presentFromRootViewController(self)
            self.interstitial = self.createAndLoadAd()
        }
    }

    
    func ShowAdmobBanner()
    {
        var w = view?.bounds.width
        var h = view?.bounds.height
        gBannerView = GADBannerView(frame: CGRectMake(0, h! - 50 , w!, 50))
        gBannerView?.adUnitID = "ca-app-pub-2807486494925046/7128618012"
        gBannerView?.delegate = self
        gBannerView?.rootViewController = self
        self.view.addSubview(gBannerView)
        //self.view.addSubview(bannerView!)
        //adViewHeight = bannerView!.frame.size.height
        var request = GADRequest()
        request.testDevices = [kGADSimulatorID , "6aa57fc4161001786a1a9e7cea470364"];
        gBannerView?.loadRequest(request)
        gBannerView?.hidden = true
        
    }
    
    func showAd()->Bool
    {
        var abc = Test()
        var VPN = abc.isVPNConnected()
        var Version = abc.platformNiceString()
        if(VPN == false && Version == "CDMA")
        {
            return false
        }
        
        return true
    }

    func showAds()
    {
        Chartboost.showInterstitial("Home" + String(AdNumber))
        AdNumber++
        println(AdNumber)
    }
    
    
    @IBAction func StartClick(sender: AnyObject) {
        self.startView!.hidden = true
        gBannerView?.hidden = true
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
     
     
    topView.hidden = true
    
    
    CheckAdOptionValue()
    if(showAd())
    {
        ShowAdmobBanner()
        if(isAdmob)
        {
            
            self.interstitial = self.createAndLoadAd()
        }
        isStopAD = false
    }
    
    
    
    
    
    self.timerVPN = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: "timerVPNMethodAutoAd:", userInfo: nil, repeats: true)
    self.timerAdmobFull = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "timerAdmobFull:", userInfo: nil, repeats: true)
  
    
 
  }
    func CheckAdOptionValue()
    {
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("Admob") != nil)
        {
            isAdmob = NSUserDefaults.standardUserDefaults().objectForKey("Admob") as Bool
            
        }
        
//        
//        if(NSUserDefaults.standardUserDefaults().objectForKey("Amazon") != nil)
//        {
//            isAmazon = NSUserDefaults.standardUserDefaults().objectForKey("Amazon") as Bool
//            
//        }
//        
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("Chart") != nil)
        {
            isChart = NSUserDefaults.standardUserDefaults().objectForKey("Chart") as Bool
            
        }
        AdmobCheck.on = isAdmob
        
        ChartboostCheck.on = isChart
    }
    //Save ADOption
    @IBAction func GoogleChange(sender: UISwitch) {
        //if(AdmobCheck.on)
        //{
        println(sender.on)
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"Admob")
        NSUserDefaults.standardUserDefaults().synchronize()
        isAdmob = sender.on
        //
        // }
        
    }
 
    
    @IBAction func СhartBoostChanged(sender: UISwitch) {
        println(sender.on)
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"Chart")
        NSUserDefaults.standardUserDefaults().synchronize()
        isChart = sender.on
        
    }
    func timerAdmobFull(timer:NSTimer) {
        //var isShowFullAdmob = false
        //var isShowFllAmazon = false
        //var isShowChartboostFirst = false
        if(isChart && isShowChartboostFirst == false)
        {
            
            Chartboost.showInterstitial("First stage")
            isShowChartboostFirst = true;
            //timerAdmobFull?.invalidate()
            
            
        }
        if(isAdmob && isShowFullAdmob == false)
        {
            
            if(self.interstitial.isReady)
            {
                showAdmob()
                //timerAdmobFull?.invalidate()
                isShowFullAdmob = true;
            }
        }
        
        
        
    }
    
    func timerVPNMethodAutoAd(timer:NSTimer) {
        println("VPN Checking....")
        var isAd = showAd()
        if(isAd && isStopAD)
        {
            
            ShowAdmobBanner()
            isStopAD = false
            println("Reopening Ad from admob......")
        }
        
        if(isAd == false && isStopAD == false)
        {
            gBannerView.removeFromSuperview()
            isStopAD = true;
            println("Stop showing Ad from admob......")
        }
    }
  
//     func gamePoint(point: Int)
//     {
//    
//    lbScore.text = String(point)
//        println(point)
//    }
//  override func prefersStatusBarHidden() -> Bool {
//    return false
//  }
    
    
    //GADBannerViewDelegate
    func adViewDidReceiveAd(view: GADBannerView!) {
        println("adViewDidReceiveAd:\(view)");
        gBannerView?.hidden = false
        
        //relayoutViews()
    }
    
    func adView(view: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        println("\(view) error:\(error)")
        gBannerView?.hidden = false
        //relayoutViews()
    }
    
    func adViewWillPresentScreen(adView: GADBannerView!) {
        println("adViewWillPresentScreen:\(adView)")
        gBannerView?.hidden = false
        
        //relayoutViews()
    }
    
    func adViewWillLeaveApplication(adView: GADBannerView!) {
        println("adViewWillLeaveApplication:\(adView)")
    }
    
    func adViewWillDismissScreen(adView: GADBannerView!) {
        println("adViewWillDismissScreen:\(adView)")
        
        // relayoutViews()
    }
    
    
    

    


}
