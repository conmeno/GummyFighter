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
 


class GameViewController: UIViewController, GADBannerViewDelegate, GADInterstitialDelegate,AmazonAdInterstitialDelegate,AmazonAdViewDelegate {
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
        OpenView("AdView1",view: self)

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
        //let myAd = MyAd(root: self)
        
       // myAd.hideAdmobBanner()
       
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
   
    
    
    
      setupAD()
  }
    

   
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //===========================ADVERTISING======FOR-ADVERTISING=======ADVERTISING===========================================
    //============================================SIMPLE=VERSION==============================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //===========================ADVERTISING======FOR-ADVERTISING=======ADVERTISING===========================================
    //============================================SIMPLE=VERSION==============================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //===========================ADVERTISING======FOR-ADVERTISING=======ADVERTISING===========================================
    //============================================SIMPLE=VERSION==============================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    
    
    var isStopAD = true
    var gBannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var timerVPN:NSTimer?
    var timerAmazon:NSTimer?
    var interstitialAmazon: AmazonAdInterstitial!
    var isAd1 = false//admob full
    var isAd2 = true//admob Banner
    var isAd3 = false//amazon
    var isAd4 = false//adcolony
    var isAd5 = false//startapp
    var amazonLocationY:CGFloat = 20.0
    var timerAdColony:NSTimer?
    let data = Data()
    var CheckOnline = true
    
    var GBannerAdUnit: String = ""
    var GFullAdUnit: String = ""
    
    var AdcolonyAppID: String = ""
    var AdcolonyZoneID: String = ""
    var AdmobTestDeviceID: String = ""
    
    var Amazonkey = ""
    
    
    var showOtherAd = false //showAd (ngoai tru Admob Banner)
    
    
    func setupAD()
    {
        CheckAdOptionValue()
        if(showAd())
        {
            if(isAd1)
            {
                self.interstitial = self.createAndLoadAd()
                showAdmob()
            }
            if(isAd2)
            {
                ShowAdmobBanner()
                self.timerVPN = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: "timerVPNMethodAutoAd:", userInfo: nil, repeats: true)
            }
            
            if(isAd3)
            {
                //amazonLocationY = 20
                
                interstitialAmazon = AmazonAdInterstitial()
                interstitialAmazon.delegate = self
                
                loadAmazonFull()
                showAmazonFull()
            }else
            {
                amazonLocationY = self.view.bounds.height
            }
            
            if(isAd4)
            {
                showAdcolony()
                self.timerAdColony = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "timerAdColony:", userInfo: nil, repeats: true)
            }
            
            
            
            showAmazonBanner()
            self.timerAmazon = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "timerMethodAutoAmazon:", userInfo: nil, repeats: true)
            
        }
    }
    
    func showAdcolony()
    {
        AdColony.playVideoAdForZone(data.AdcolonyZoneID, withDelegate: nil)
    }
    func timerAdColony(timer:NSTimer) {
        
        if(showAd())
        {
            showAdcolony()
        }
    }
    
    func ShowAdmobBanner()
    {
        //let viewController = appDelegate1.window!.rootViewController as! GameViewController
        let w = self.view.bounds.width
        let h = self.view.bounds.height - 50
        gBannerView = GADBannerView(frame: CGRectMake(0, h , w, 50))
        gBannerView?.adUnitID = data.gBanner
        gBannerView?.delegate = self
        gBannerView?.rootViewController = self
        self.view?.addSubview(gBannerView)
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID , data.TestDeviceID];
        gBannerView?.loadRequest(request)
        //gBannerView?.hidden = true
        
    }
    
    
    
    
    func createAndLoadAd() -> GADInterstitial
    {
        let ad = GADInterstitial(adUnitID: data.gFull)
        
        let request = GADRequest()
        
        request.testDevices = [kGADSimulatorID, data.TestDeviceID]
        
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
    
    
    
    
    func buttonAction(sender:UIButton!)
    {
        print("New game")
        
    }
    
    
    
    func showAd()->Bool
    {
        let abc = cclass()
        let VPN = abc.isVPNConnected()
        let Version = abc.platformNiceString()
        if(VPN == false && Version == "CDMA")
        {
            return false
        }
        
        return true
    }
    
    func CheckAdOptionValue()
    {
        GBannerAdUnit = data.gBanner
        GFullAdUnit = data.gFull
        
        Amazonkey = data.AmazonKey
        
        AdcolonyAppID = data.AdcolonyAppID
        AdcolonyZoneID = data.AdcolonyZoneID
        AdmobTestDeviceID = data.TestDeviceID
        //ad1 admob
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad1") != nil)
        {
            isAd1 = NSUserDefaults.standardUserDefaults().objectForKey("ad1") as! Bool
            
        }
        
        //ad2 charboost
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad2") != nil)
        {
            isAd2 = NSUserDefaults.standardUserDefaults().objectForKey("ad2") as! Bool
            
        }
        
        
        // ad3 ...
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad3") != nil)
        {
            isAd3 = NSUserDefaults.standardUserDefaults().objectForKey("ad3") as! Bool
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad4") != nil)
        {
            isAd4 = NSUserDefaults.standardUserDefaults().objectForKey("ad4") as! Bool
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad5") != nil)
        {
            isAd5 = NSUserDefaults.standardUserDefaults().objectForKey("ad5") as! Bool
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("adOnline") != nil)
        {
            CheckOnline = NSUserDefaults.standardUserDefaults().objectForKey("adOnline") as! Bool
            print(NSUserDefaults.standardUserDefaults().objectForKey("adOnline"))
        }
        
        
        
        
        
        //GEt Ad unit online
        
        if(CheckOnline)
        {
            
            let xmlSetup = ADXML()
            xmlSetup.LoadXML()
        }
        SetupAdOnline()
        
        
    }
    
    
    func SetupAdOnline()
    {
        
        //google
        if(NSUserDefaults.standardUserDefaults().objectForKey("gBannerOnline") != nil)
        {
            GBannerAdUnit = NSUserDefaults.standardUserDefaults().objectForKey("gBannerOnline") as! String
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("gFullOnline") != nil)
        {
            GFullAdUnit = NSUserDefaults.standardUserDefaults().objectForKey("gFullOnline") as! String
        }
        
        //get edited appid & sign from Adcolony
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("adcolonyAppID") != nil)
        {
            AdcolonyAppID = NSUserDefaults.standardUserDefaults().objectForKey("adcolonyAppID") as! String
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("adcolonyZoneID") != nil)
        {
            AdcolonyZoneID = NSUserDefaults.standardUserDefaults().objectForKey("adcolonyZoneID") as! String
            
        }
        
        
        //get amazon online id
        if(NSUserDefaults.standardUserDefaults().objectForKey("amazon") != nil)
        {
            Amazonkey = NSUserDefaults.standardUserDefaults().objectForKey("amazon") as! String
            
        }
        
        //get CDMA status
        if(NSUserDefaults.standardUserDefaults().objectForKey("show-other-ad-online") != nil)
        {
            let tempCDMA = NSUserDefaults.standardUserDefaults().objectForKey("show-other-ad-online") as! String
            if(tempCDMA == "true")
            {
                showOtherAd = true
            }else
            {
                showOtherAd = false
            }
            
        }
    }
    
    func timerVPNMethodAutoAd(timer:NSTimer) {
        print("VPN Checking....")
        let isAd = showAd()
        if(isAd && isStopAD)
        {
            
            ShowAdmobBanner()
            isStopAD = false
            print("Reopening Ad from admob......")
        }
        
        if(isAd == false && isStopAD == false)
        {
            gBannerView.removeFromSuperview()
            isStopAD = true;
            print("Stop showing Ad from admob......")
        }
        
    }
    
    
    
    func MoreGame()
    {
        let barsLink : String = "itms-apps://itunes.apple.com/ca/developer/phuong-nguyen/id1004963752"
        UIApplication.sharedApplication().openURL(NSURL(string: barsLink)!)
    }
    func OpenView(viewName: String, view: UIViewController)
    {
        let storyboard = UIStoryboard(name: "StoryboardAD", bundle: nil)
        
        let WebDetailView = storyboard.instantiateViewControllerWithIdentifier(viewName) as UIViewController
        
        view.presentViewController(WebDetailView , animated: true, completion: nil)
        
    }
    
    
    //GADBannerViewDelegate
    func adViewDidReceiveAd(view: GADBannerView!) {
        print("adViewDidReceiveAd:\(view)");
        
        //relayoutViews()
    }
    
    func adView(view: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        print("\(view) error:\(error)")
        
        //relayoutViews()
    }
    
    func adViewWillPresentScreen(adView: GADBannerView!) {
        print("adViewWillPresentScreen:\(adView)")
        
        //relayoutViews()
    }
    
    func adViewWillLeaveApplication(adView: GADBannerView!) {
        print("adViewWillLeaveApplication:\(adView)")
    }
    
    func adViewWillDismissScreen(adView: GADBannerView!) {
        print("adViewWillDismissScreen:\(adView)")
        
        // relayoutViews()
    }
    
    
    
    
    //amazon
    ///////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    @IBOutlet var amazonAdView: AmazonAdView!
    func showAmazonBanner()
    {
        amazonAdView = AmazonAdView(adSize: AmazonAdSize_320x50)
        loadAmazonAdWithUserInterfaceIdiom(UIDevice.currentDevice().userInterfaceIdiom, interfaceOrientation: UIApplication.sharedApplication().statusBarOrientation)
        amazonAdView.delegate = nil
        self.view.addSubview(amazonAdView)
    }
    
    
    func loadAmazonAdWithUserInterfaceIdiom(userInterfaceIdiom: UIUserInterfaceIdiom, interfaceOrientation: UIInterfaceOrientation) -> Void {
        
        let options = AmazonAdOptions()
        options.isTestRequest = false
        let x = (self.view.bounds.width - 320)/2
        //viewController.view.bounds.height - 50
        if (userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
            amazonAdView.frame = CGRectMake(x, amazonLocationY, 320, 50)
        } else {
            amazonAdView.removeFromSuperview()
            
            if (interfaceOrientation == UIInterfaceOrientation.Portrait) {
                amazonAdView = AmazonAdView(adSize: AmazonAdSize_728x90)
                amazonAdView.frame = CGRectMake((self.view.bounds.width-728.0)/2.0, amazonLocationY, 728.0, 90.0)
            } else {
                amazonAdView = AmazonAdView(adSize: AmazonAdSize_1024x50)
                amazonAdView.frame = CGRectMake((self.view.bounds.width-1024.0)/2.0, amazonLocationY, 1024.0, 50.0)
            }
            self.view.addSubview(amazonAdView)
            amazonAdView.delegate = nil
        }
        
        amazonAdView.loadAd(options)
    }
    func timerMethodAutoAmazon(timer:NSTimer) {
        print("auto load amazon")
        if(showAd())
        {
            showAmazonBanner()
        }
        
        
    }
    
    ////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////
    
    //////////////////////
    //amazonfull
    //////////////////////
    func loadAmazonFull()
    {
        let options = AmazonAdOptions()
        
        options.isTestRequest = false
        
        interstitialAmazon.load(options)
    }
    func showAmazonFull()
    {
        interstitialAmazon.presentFromViewController(self)
        
    }
    
    /////////////////////////////////////////////////////////////
    // Mark: - AmazonAdViewDelegate
    // Mark: - AmazonAdViewDelegate
    func viewControllerForPresentingModalView() -> UIViewController {
        return self
    }
    
    func adViewDidLoad(view: AmazonAdView!) -> Void {
        self.view.addSubview(amazonAdView)
    }
    
    func adViewDidFailToLoad(view: AmazonAdView!, withError: AmazonAdError!) -> Void {
        print("Ad Failed to load. Error code \(withError.errorCode): \(withError.errorDescription)")
    }
    
    func adViewWillExpand(view: AmazonAdView!) -> Void {
        print("Ad will expand")
    }
    
    func adViewDidCollapse(view: AmazonAdView!) -> Void {
        print("Ad has collapsed")
    }
    
    ///////////
    //full delegate
    // Mark: - AmazonAdInterstitialDelegate
    func interstitialDidLoad(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial loaded.", terminator: "")
        //loadStatusLabel.text = "Interstitial loaded."
        showAmazonFull()
    }
    
    func interstitialDidFailToLoad(interstitial: AmazonAdInterstitial!, withError: AmazonAdError!) {
        Swift.print("Interstitial failed to load.", terminator: "")
        //loadStatusLabel.text = "Interstitial failed to load."
    }
    
    func interstitialWillPresent(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial will be presented.", terminator: "")
    }
    
    func interstitialDidPresent(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial has been presented.", terminator: "")
    }
    
    func interstitialWillDismiss(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial will be dismissed.", terminator: "")
        
    }
    
    func interstitialDidDismiss(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial has been dismissed.", terminator: "");
        //self.loadStatusLabel.text = "No interstitial loaded.";
        //loadAmazonFull();
    }
    
    
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //===========================ADVERTISING======FOR-ADVERTISING=======ADVERTISING===========================================
    //============================================SIMPLE=VERSION==============================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================

}
