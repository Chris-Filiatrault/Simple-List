//
//  TestHome.swift
//  Simple List
//
//  Created by Chris Filiatrault on 16/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

import SwiftUI

struct TestHome: View {
   
   @ObservedObject var userPurchase = UserPurchase()
   @State var purchased: Bool = false
   //@State var showBuyView: Bool = false
    var body: some View {
      
      VStack {
      
         BuyView(purchased: $purchased)
         

      }
    }
}
