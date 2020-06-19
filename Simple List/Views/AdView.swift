//
//  AdView.swift
//  Simple List
//
//  Created by Chris Filiatrault on 17/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

// Simple list banner ad ID
// Put it in place when pushing to production
// ca-app-pub-8331624426045290/4014482304

// Otherwise use the test banner ad id
// ca-app-pub-3940256099942544/2934735716



import SwiftUI
import GoogleMobileAds


struct AdView : UIViewRepresentable {

   func makeUIView(context: UIViewRepresentableContext<AdView>) -> GADBannerView {

      let banner = GADBannerView(adSize: kGADAdSizeBanner)
      banner.adUnitID = "ca-app-pub-8331624426045290/4014482304"
      banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
      banner.load(GADRequest())

      return banner
   }

   func updateUIView(_ uiView: GADBannerView, context: UIViewRepresentableContext<AdView>) {
   }

}



// Alternative implementation

//
//import SwiftUI
//import GoogleMobileAds
//import UIKit
//
//final private class BannerVC: UIViewControllerRepresentable  {
//
//    func makeUIViewController(context: Context) -> UIViewController {
//        let view = GADBannerView(adSize: kGADAdSizeBanner)
//
//        let viewController = UIViewController()
//        view.adUnitID = "ca-app-pub-3940256099942544/2934735716"
//        view.rootViewController = viewController
//        viewController.view.addSubview(view)
//        viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
//        view.load(GADRequest())
//
//        return viewController
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
//}
//
//struct Banner:View{
//    var body: some View{
//        HStack{
//            Spacer()
//            BannerVC().frame(width: 320, height: 50, alignment: .center)
//            Spacer()
//        }
//    }
//}
