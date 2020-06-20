//
//  TestHome.swift
//  Simple List
//
//  Created by Chris Filiatrault on 16/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//
//
//
// For testing
//


import SwiftUI

struct TestHome: View {
   
   @State var purchased: Bool = false
   @EnvironmentObject var globalVariables: GlobalVariableClass
   //@ObservedObject var userPurchase = UserPurchase()

   init() {

   }

    var body: some View {

      VStack {

         BuyView(purchased: $purchased)


      }
    }
}
