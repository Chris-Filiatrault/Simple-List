//
//  AdView.swift
//  Simple List
//
//  Created by Chris Filiatrault on 17/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

// Simple list banner ad ID
// ca-app-pub-8331624426045290/4014482304


import SwiftUI
import GoogleMobileAds


struct AdView : UIViewRepresentable {

   func makeUIView(context: UIViewRepresentableContext<AdView>) -> GADBannerView {

      let banner = GADBannerView(adSize: kGADAdSizeBanner)
      // ==== UPDATE BEFORE RELEASE ====
      banner.adUnitID = "ca-app-pub-8331624426045290/4014482304"
      banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
      banner.load(GADRequest())
      

      return banner
   }

   func updateUIView(_ uiView: GADBannerView, context: UIViewRepresentableContext<AdView>) {
   }

}

