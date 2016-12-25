//
//  ViewController.swift
//  UnityAdsSample
//
//  Created by tony on 2016/12/19.
//  Copyright © 2016年 chengkaizone. All rights reserved.
//

import UIKit
import UnityAds

class ViewController: UIViewController {
    
    @IBOutlet weak var showAdsButton: UIButton!
    
    //let gameId = "1161733"
    let gameId = "1224898"
    
    var videoReady: Bool = false
    var rewardedVideoReady: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAdsButton.isEnabled = false
        
        UnityAds.setDebugMode(false)
        
        loadAds()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAds(_ sender: AnyObject) {
        
        if videoReady {
            UnityAds.show(self, placementId: "video")
        } else if rewardedVideoReady {
            UnityAds.show(self, placementId: "rewardedVideoReady")
        }
    }
    
    
    func loadAds() {
        if !UnityAds.isReady() {
            UnityAds.initialize(gameId, delegate: self)
        }
    }
    
}


extension ViewController: UnityAdsDelegate {
    
    //MARK: - UnityAdsDelegate
    
    func unityAdsReady(_ placementId: String) {
        print("======================unityAdsReady: \(placementId)")
        showAdsButton.isEnabled = true
        
        switch placementId {
        case "video":
            videoReady = true
            break;
        case "rewardedVideo":
            rewardedVideoReady = true
            break;
        default:
            print("Unhandled placement id")
        }
        
    }
    
    func unityAdsDidStart(_ placementId: String) {
        print("unityAdsDidStart: \(placementId)")
    }
    
    func unityAdsDidError(_ error: UnityAdsError, withMessage message: String) {
        print("unityAdsDidError: \(error.rawValue) \(message)");
        
        showAdsButton.isEnabled = false
    }
    
    func unityAdsDidFinish(_ placementId: String, with state: UnityAdsFinishState) {
        print("unityAdsDidFinish: \(placementId) \(state.rawValue)")
        showAdsButton.isEnabled = false
        
        switch placementId {
        case "video":
            videoReady = false
            break;
        case "rewardedVideo":
            rewardedVideoReady = false
            break;
        default:
            print("Unhandled placement id")
        }

        loadAds()
    }
    
}

