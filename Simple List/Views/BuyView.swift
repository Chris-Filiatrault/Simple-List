//
//  BuyView.swift
//  Simple List
//
//  Created by Chris Filiatrault on 16/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//
import Foundation
import SwiftUI
import StoreKit
struct BuyView: View {
   
   @State var numPurchases: Int = 0

   @EnvironmentObject var globalVariables: GlobalVariableClass
   
   @Binding var purchased: Bool
   @ObservedObject var products = ProductsDB.shared
   
   
   let productIDs: [String] = IAPManager.shared.returnProductIDs()
   let product: SKProduct = SKProduct()
   var body: some View {
      GeometryReader { geometry in
         VStack {
            
            Button(action: {
               UserDefaults.standard.set(true, forKey: "paidToRemoveAds")
            }) {
               Text("Paid")
            }
            
            Button(action: {
               UserDefaults.standard.set(false, forKey: "paid")
               print("Set to false")
            }) {
               Text("Not paid")
            }
            
            
            
            
            Button(action: {
               IAPManager.shared.restorePurchasesV5()
            }) {
               Text("Restore purchases")
            }
            
            Button(action: {
               IAPManager.shared.getProductsV5()
            }) {
               Text("Show products")
            }
            
            
            
            
            List {
               ForEach((0 ..< self.products.items.count), id: \.self) { product in
                  Button(action: {
                     IAPManager.shared.purchaseV5(product: self.products.items[product])
                     self.numPurchases += 1
                  }) {
                     HStack {
                        Text(IAPManager.shared.formatPrice(for: self.products.items[product]) ?? "")
                        
                        Text(self.products.items[product].localizedDescription)
                     }
                  }
               }
            }
            
            
            AdView()
               .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.04)
               .padding()
            
         }
      }
   }
}
