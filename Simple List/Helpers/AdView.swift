//
//  AdView.swift
//  Simple List
//
//  Created by Chris Filiatrault on 17/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

// Simple list banner ad ID
// ca-app-pub-8331624426045290~5019801581


// Test banner ad id
// ca-app-pub-3940256099942544/2934735716

import SwiftUI
import GoogleMobileAds

struct TestAdView: View {
    var body: some View {
      GeometryReader { geometry in
      AdView()
         .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.04)
      }
    }
}

struct AdView : UIViewRepresentable {
   
   func makeUIView(context: UIViewRepresentableContext<AdView>) -> GADBannerView {
      
      let banner = GADBannerView(adSize: kGADAdSizeBanner)
      banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
      banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
      banner.load(GADRequest())
      
      return banner
   }
   
   func updateUIView(_ uiView: GADBannerView, context: UIViewRepresentableContext<AdView>) {
      
   }
}
