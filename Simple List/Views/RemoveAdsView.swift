//
//  RemoveAdsView.swift
//  Simple List
//
//  Created by Chris Filiatrault on 16/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//


import SwiftUI

struct RemoveAdsView: View {
   
   @State var restorePurchaseInfoAlert: Bool = false
   @Binding var showRemoveAdsView: Bool
   @Binding var purchaseMade: Bool

   @ObservedObject var products = ProductsDB.shared
   @ObservedObject var globalVariables = GlobalVariableClass()


   let backgroundColour: Color = Color(red: 0, green: 144/255, blue: 158/255, opacity: 1)
   
   
   var body: some View {
      
      NavigationView {
         GeometryReader { geometry in
            
            VStack {
               
               // ==========================================================================
               // === Show error message if products fail to load from App Store Connect ===
               // ==========================================================================
               if self.products.items.isEmpty {
                  ErrorMessage()
               }
               
                  
               // =================================================
               // === Show the main view if the products loaded ===
               // =================================================
               else if !self.products.items.isEmpty {
                  VStack {
                     
                     Spacer()

                     
                     // Buttons
                     VStack {
                        
                        Text("Remove Ads for \(IAPManager.shared.formatPrice(for: self.products.items[0]) ?? "")")
                           .font(.title)
                        //                              .padding(.vertical, 10)
                        
                        
                        // Purchase/remove button
                        Button(action: {
                           let removeAdsProduct = self.products.items[0]
                           IAPManager.shared.purchaseV5(product: removeAdsProduct)
                        }) {
                           Text("Remove")
                              .bold()
                              .frame(minWidth: 100, maxWidth: 200)
                              .font(.subheadline)
                              .padding(10)
                              .background(Color("blueButton"))
                              .foregroundColor(.white)
                              .cornerRadius(15)
                              .transition(.scale)
                              .edgesIgnoringSafeArea(.horizontal)                              }
                           .contentShape(Rectangle())
                           .padding(.vertical, 5)
                        
                        
                        HStack {
                        // Restore purchase button
                        Button(action: {
                           IAPManager.shared.restorePurchasesV5()
                        }) {
                           Text("Restore purchase")
                              .bold()
                              .cornerRadius(20)
                              .font(.subheadline)
                              .padding(5)
                              .frame(minWidth: 50)
                        }.contentShape(Rectangle())
                        
                     
                        // Question mark button
                           Button(action: {
                              self.restorePurchaseInfoAlert = true
                           }) {
                              Image(systemName: "questionmark.circle")
                                 .foregroundColor(Color("restorePurchaseButton"))
                                 .padding(5)
                           }
                           
                        }
                        
                        
                        
                     } // End of buttons
                     
                     Spacer()
                     Divider().padding(.vertical, 3)
                     Spacer()
                     
                     // Photo view
                     VStack {
                        Text("Help me buy my next coffee! ☕️")
                           .font(.headline)
                           .padding(.vertical, 5)
                        
                        Image("chris-photo")
                           .resizable()
                           .aspectRatio(contentMode:.fit)
                           .clipShape(Circle())
                           .padding(.vertical, 7)
                           .overlay(
                              Circle().stroke(Color("blackWhiteFont"), lineWidth: 2))
                        .frame(minWidth: 150, maxWidth: 250, minHeight: 150, maxHeight: 250)
                        
                        
                        Text("Chris Filiatrault")
                           .font(.title)
                        
                        Text("Creator of Simple List")
                           .font(.headline)
                           .padding(.bottom, 10)
                     }
                     
                     Spacer()
                  } // End of Content VStack
                     .padding()
                     .alert(isPresented: self.$restorePurchaseInfoAlert) {
                        Alert(title: Text("Information"), message: Text("If you have paid to remove ads on another device, you can remove the ads on this device for free by restoring the purchase."), dismissButton: .default(Text("Done")))
                  }
                  
               }
            }
            .onDisappear {
               if UserDefaults.standard.object(forKey: "purchased") as? Bool ?? nil == true {
                  self.purchaseMade = true
               }
            }
               
               
               // Navigation bar details
               .navigationBarTitle("", displayMode: .inline)
               .navigationBarItems(leading:
                  Button(action: {
                     self.showRemoveAdsView.toggle()
                  }) {
                     Text("Cancel")
                        .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 15))
                  }
            )
         }
      }
      .environment(\.horizontalSizeClass, .compact)
   }
}

