//
//  BannerAdView.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 01/03/24.
//

import SwiftUI
import GoogleMobileAds

struct BannerAdView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        let banner = GADBannerView(adSize: GADAdSizeBanner)
        
        // replace with actual admob ad unit id
//        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        banner.adUnitID = "ca-app-pub-7871185710478480/8986859805"
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(GADRequest())
        
        return banner
    }
    
    func updateUIView(_ uiView: GADBannerView, context: Context) {
        
    }
    
}

#Preview {
    BannerAdView()
}
