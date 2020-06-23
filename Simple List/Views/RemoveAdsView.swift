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
   let backgroundColour: Color = Color(red: 0, green: 144/255, blue: 158/255, opacity: 1)
   
   
   var body: some View {
      
      NavigationView {
         GeometryReader { geometry in
            
            VStack {
               
               // Show error message if products fail to load from App Store Connect
               if self.products.items.isEmpty {
                  ErrorMessage()
               }
                  
                  // Show the main view if the products loaded
               else if !self.products.items.isEmpty {
                     VStack {
                        Spacer()
                        
//
//                     if UserDefaults.standard.object(forKey: "purchased") as? Bool ?? nil != true {
//                        AdView()
//                           .frame(width: 320, height: 50, alignment: .center)
//                           .padding(.top, 5)
//                     }
//                     else if UserDefaults.standard.object(forKey: "purchased") as? Bool ?? nil == true {
//                        // Show nothing
//                     }
//
//                        Spacer()
                        
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
                              Text("Support my work")
                                 .bold()
                                 .frame(width: geometry.size.width * 0.6)
                                 .font(.subheadline)
                                 .padding(10)
                                 .background(Color("blueButton"))
                                 .foregroundColor(.white)
                                 .cornerRadius(15)
                                 .transition(.scale)
                                 .edgesIgnoringSafeArea(.horizontal)                              }
                              .contentShape(Rectangle())
                              .padding(.vertical, 10)
                           
                           
                           HStack {
                              // Restore purchase button
                              Button(action: {
                                 IAPManager.shared.restorePurchasesV5()
                              }) {
                                 Text("Restore purchase")
                                    .bold()
                                    .cornerRadius(20)
                                    .font(.subheadline)
                                    .frame(minWidth: 50)
                              }.contentShape(Rectangle())
                              
                              
                              Spacer()
                              
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
                              
                           }
                           .padding(.horizontal, geometry.size.width * 0.2)
                           
                        }
                        
                        Spacer()
                        Divider()
                        Spacer()
                        
                        // Photo view
                        VStack {
                           Text("I hope you have been enjoying the app! 😁")
                             .font(.headline)
                             .padding(.vertical, 10)
                           
                           Image("chris-photo")
                              .resizable()
                              .aspectRatio(contentMode:.fit)
                              .frame(width: 250, height: 250)
                              .clipShape(Circle())
                              .padding(.vertical, 10)
                              .overlay(
                                 Circle().stroke(Color("blackWhiteFont"), lineWidth: 2))
                           
                              
                           Text("Chris Filiatrault")
                              .font(.title)
                           
                           Text("Creator of Simple List")
                              .font(.headline)
                              .padding(.bottom, 10)
                        }
                        
                     
                        
                     Spacer()
                     } // End of Content VStack
                        .padding()
                     //                        .padding(.top, geometry.size.height * 0.15)
                     
                  
                  
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






//               .background(backgroundColour.edgesIgnoringSafeArea(.all))


////
////  RemoveAdsView.swift
////  Simple List
////
////  Created by Chris Filiatrault on 16/6/20.
////  Copyright © 2020 Chris Filiatrault. All rights reserved.
////
//
//
//
//
//import SwiftUI
//
//struct RemoveAdsView: View {
//
//   @Binding var showRemoveAdsView: Bool
//   @ObservedObject var products = ProductsDB.shared
//   @EnvironmentObject var globalVariables: GlobalVariableClass
//
//
//
//   var body: some View {
//
//      NavigationView {
//         GeometryReader { geometry in
//            VStack {
//               if !self.products.items.isEmpty {
//                  Text("Remove Ads for \(IAPManager.shared.formatPrice(for: self.products.items[0]) ?? "")")
//                     .bold()
//               } else {
//                  // This should be an alert, not the text on the page
//                  Text("An error occurred. \nPlease ensure you're connected to the internet, restart the app and try again.")
//               }
//
//
//               if !self.products.items.isEmpty {
//                  // ===Buttons===
//                  HStack(alignment: .center) {
//
//                     // Cancel button
//                     Button(action: {
//                        self.showRemoveAdsView.toggle()
//                     }) {
//                        Text("Cancel")
//                           .bold()
//                           .cornerRadius(20)
//                           .font(.subheadline)
//                           .frame(minWidth: 50)
//                     }.contentShape(Rectangle())
//
//                     // Purchase/remove button
//                     Button(action: {
//                        if !self.products.items.isEmpty {
//                           let removeAdsProduct = self.products.items[0]
//                           IAPManager.shared.purchaseV5(product: removeAdsProduct)
//
//                        }
//                     }) {
//                        Text("Remove")
//                           .bold()
//                           .frame(minWidth: 50)
//                           .font(.subheadline)
//                           .padding(10)
//                           .background(Color("blueButton"))
//                           .foregroundColor(.white)
//                           .cornerRadius(10)
//                           .transition(.scale)
//                           .edgesIgnoringSafeArea(.horizontal)
//                     }
//                     .contentShape(Rectangle())
//                     .padding(.leading, 20)
//
//                  }
//                  .padding(.top, 10)
//
//                  // Restore purchase button
//                  Button(action: {
//                     IAPManager.shared.restorePurchasesV5()
//                  }) {
//                     Text("Restore purchase")
//                        .bold()
//                        .cornerRadius(20)
//                        .font(.subheadline)
//                        .frame(minWidth: 50)
//                  }.contentShape(Rectangle())
//                     .padding()
//               }
//
//               Spacer()
//
//               if UserDefaults.standard.object(forKey: "purchased") as? Bool ?? nil != true {
//                  AdView()
//                     .frame(width: 320, height: 50, alignment: .center)
//                     .padding(.top, 5)
//               }
//               else if UserDefaults.standard.object(forKey: "purchased") as? Bool ?? nil == true {
//                  // Show nothing
//               }
//
//            }
//            .padding()
//            .padding(.top, geometry.size.height * 0.15)
//
//         }
//
//         .navigationBarTitle("", displayMode: .inline)
//         .navigationBarItems(leading:
//            Button(action: {
//               self.showRemoveAdsView.toggle()
//            }) {
//               Text("Cancel")
//                  .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 15))
//            }
//         )
//         .background(Color("background").edgesIgnoringSafeArea(.all))
//
//
//      }
//      .environment(\.horizontalSizeClass, .compact)
//
//   }
//}
//
//
//
//
