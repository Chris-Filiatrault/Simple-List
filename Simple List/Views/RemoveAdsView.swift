//
//  RemoveAdsView.swift
//  Simple List
//
//  Created by Chris Filiatrault on 16/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//




import SwiftUI

struct RemoveAdsView: View {

   @Binding var showRemoveAdsView: Bool
   @ObservedObject var products = ProductsDB.shared
   @EnvironmentObject var globalVariables: GlobalVariableClass

   var body: some View {

      NavigationView {
      GeometryReader { geometry in

         VStack {

            if !self.products.items.isEmpty {
            Text("Remove Ads for \(IAPManager.shared.formatPrice(for: self.products.items[0]) ?? "")")
               .bold()
            } else {
               // This should be an alert, not the text on the page
               Text("An error occurred. \nPlease ensure you're connected to the internet, restart the app and try again.")
            }

            
            if !self.products.items.isEmpty {
            // ===Buttons===
            HStack(alignment: .center) {

               // Cancel button
               Button(action: {
                  self.showRemoveAdsView.toggle()
               }) {
                  Text("Cancel")
                     .bold()
                     .cornerRadius(20)
                     .font(.subheadline)
                     .frame(minWidth: 50)
               }.contentShape(Rectangle())
               
               // Remove button
               Button(action: {
                  if !self.products.items.isEmpty {
                  let removeAdsProduct = self.products.items[0]
                  IAPManager.shared.purchaseV5(product: removeAdsProduct)
                  }
               }) {
                  Text("Remove")
                     .bold()
                     .frame(minWidth: 50)
                     .font(.subheadline)
                     .padding(10)
                     .background(Color("blueButton"))
                     .foregroundColor(.white)
                     .cornerRadius(10)
                     .transition(.scale)
                     .edgesIgnoringSafeArea(.horizontal)
               }
               .contentShape(Rectangle())
               .padding(.leading, 20)

            }
            .padding(.top, 10)

            // Restore purchase button
            Button(action: {

               IAPManager.shared.restorePurchasesV5()
               // Remove if successful
               // self.showRemoveAdsView.toggle()

            }) {
               Text("Restore purchase")
                  .bold()
                  .cornerRadius(20)
                  .font(.subheadline)
                  .frame(minWidth: 50)
            }.contentShape(Rectangle())
            .padding()
               
            }
            

            Spacer()
            if UserDefaults.standard.object(forKey: "purchased") as? Bool ?? nil != true {
               AdView()
                  .frame(width: 320, height: 50, alignment: .center)
                  .padding(.top, 5)
            }
            
            
            
         }
         .padding()
         .padding(.top, geometry.size.height * 0.15)
         
            }

         .navigationBarTitle("", displayMode: .inline)
         .navigationBarItems(leading:
               Button(action: {
                  self.showRemoveAdsView.toggle()
               }) {
                  Text("Cancel")
                  .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 15))
               }
      )

      .background(Color("background").edgesIgnoringSafeArea(.all))


      }
      .environment(\.horizontalSizeClass, .compact)
   }
}




