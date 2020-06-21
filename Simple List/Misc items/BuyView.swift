////
////  BuyView.swift
////  Simple List
////
////  Created by Chris Filiatrault on 16/6/20.
////  Copyright © 2020 Chris Filiatrault. All rights reserved.
////
//
//
//
////// Add this back when implementing the in-app purchase to remove ads
//
//
//
//import SwiftUI
//import StoreKit
//
//struct BuyView: View {
//
//   @State var numPurchases: Int = 0
//   @ObservedObject var products = ProductsDB.shared
//   @Binding var purchased: Bool
////   @ObservedObject var userPurchase = UserPurchase()
//   //@EnvironmentObject var globalVariables: GlobalVariableClass
//
//
//
//   let productIDs: [String] = IAPManager.shared.returnProductIDs()
//   let product: SKProduct = SKProduct()
//   var body: some View {
//
//
//      GeometryReader { geometry in
//         VStack {
//
//            Button(action: {
//               UserDefaults.standard.set(true, forKey: "purchased")
//               print("Set to true")
//            }) {
//               Text("Paid")
//            }
//
//            Button(action: {
//               UserDefaults.standard.set(false, forKey: "purchased")
//               print("Set to false")
//            }) {
//               Text("Not paid")
//            }
//
//            Button(action: {
//
//            print(UserDefaults.standard.object(forKey: "purchased") as? Bool ?? nil)
//
//            }) {
//               Text("Show user default for payment")
//            }
//
//
//
//            Button(action: {
//               IAPManager.shared.restorePurchasesV5()
//            }) {
//               Text("Restore purchases")
//            }
//
//            Button(action: {
//               IAPManager.shared.getProductsV5()
//            }) {
//               Text("Show products")
//            }
//
//
//
//
//            List {
//               ForEach((0 ..< self.products.items.count), id: \.self) { product in
//                  Button(action: {
//                     IAPManager.shared.purchaseV5(product: self.products.items[product])
//                     self.numPurchases += 1
//                  }) {
//                     HStack {
//                        Text(IAPManager.shared.formatPrice(for: self.products.items[product]) ?? "")
//
//                        Text(self.products.items[product].localizedDescription)
//                     }
//                  }
//               }
//            }
//
//
////            if self.userPurchase.purchased == false {
////            AdView()
////               .frame(width: 320, height: 50, alignment: .center)
////            }
//
//            if UserDefaults.standard.object(forKey: "purchased") as? Bool ?? true != true {
//            AdView()
//               .frame(width: 320, height: 50, alignment: .center)
//            }
//
//         }
//         .onAppear {
//            IAPManager.shared.getProductsV5()
//         }
//      }
//   }
//}
//
//
//
//
//
//
//
//
