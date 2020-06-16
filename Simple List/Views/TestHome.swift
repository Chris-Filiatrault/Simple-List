//
//  TestHome.swift
//  Simple List
//
//  Created by Chris Filiatrault on 16/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

import SwiftUI

struct TestHome: View {
   
   @State var purchased: Bool = false
    var body: some View {
      
      VStack {
      Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
      
      BuyView(purchased: $purchased)
      }
    }
}
