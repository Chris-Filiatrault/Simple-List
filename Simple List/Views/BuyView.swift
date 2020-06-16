//
//  BuyView.swift
//  Simple List
//
//  Created by Chris Filiatrault on 16/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

import SwiftUI
struct BuyView: View {
   @Binding var purchased: Bool
   @ObservedObject var products = ProductsDB.shared
   var body: some View {
      
      VStack {
         Button("Restore") {
            IAPManager.shared.restorePurchasesV5()
         }
         
         
         List {
            ForEach((0 ..< self.products.items.count), id: \.self) { column in
               Button(action: {
                  IAPManager.shared.purchaseV5(product: self.products.items[column])
               }) {
                  Text(self.products.items[column].localizedDescription)
               }
            }
         }
         
//         List {
//            ForEach((0 ..< self.products.items.count), id: \.self) { column in
//               Text(self.products.items[column].localizedDescription)
//                  .onTapGesture {
//                     IAPManager.shared.purchaseV5(product: self.products.items[column])
//               }
//            }
//         }
      }
   }
}
