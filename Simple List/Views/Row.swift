//
//  Row.swift
//  Simple List
//
//  Created by Chris Filiatrault on 10/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

import SwiftUI

struct Row: View {
   
   @EnvironmentObject var globalVariables: GlobalVariableClass
   
   var thisItem: Item
   @State var markedOff: Bool
   @State var position: Double
   @State var itemName: String
   

   var body: some View {
      
         Button(action: {
            print("Check circle button pressed")
            markOffItem(thisItem: self.thisItem)
         }) {
            
            HStack {
               
            Image(systemName: thisItem.markedOff ? "checkmark.circle" : "circle")
               .imageScale(.large)
            
            Text(thisItem.wrappedName)
            .font(.headline)
            .strikethrough(thisItem.markedOff, color: .gray)
               
            }.foregroundColor(thisItem.markedOff ? .gray : Color("listItemsFont"))
            
      }
   }
}

         
