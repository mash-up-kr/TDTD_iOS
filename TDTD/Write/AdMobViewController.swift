//
//  AdMobViewController.swift
//  TDTD
//
//  Created by 남수김 on 2021/11/25.
//

import UIKit
import SwiftUI
import GoogleMobileAds

struct AdMobView: View {
    var body: some View {
        AdMobViewRepresentable()
    }
}

struct AdMobViewRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = AdMobViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

final class AdMobViewController: UIViewController {
#if DEBUG
    fileprivate let adMobID = "ca-app-pub-3940256099942544/4411468910"
#else
    fileprivate let adMobID = "ca-app-pub-1355727484341694/4295095003"
#endif
    private var interstitial: GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAdMobLoad()
    }
}

// MARK: - admob

extension AdMobViewController {
    /// 전면광고로드
    func setAdMobLoad() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: adMobID, request: request) { [weak self] ad, error in
            guard let self = self else { return }
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            self.interstitial = ad
            self.interstitial?.fullScreenContentDelegate = self
            self.interstitial?.present(fromRootViewController: self)
        }
    }
}

//MARK: - 광고 콜백 등록

extension AdMobViewController: GADFullScreenContentDelegate {
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        Log("Ad did fail to present full screen content.")
    }
    
    /// Tells the delegate that the ad presented full screen content.
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        Log("Ad did present full screen content.")
    }
    
    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        Log("Ad did dismiss full screen content.")
    }
}
