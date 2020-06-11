//
//  TrailingNavBarButtons.swift
//  Simple List
//
//  Created by Chris Filiatrault on 10/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//


import SwiftUI

struct TrailingNavBarButtons: View {
   
   @EnvironmentObject var globalVariables: GlobalVariableClass
   
   @Binding var textfieldActive: Bool
   @Binding var textfieldValue: String
   @Binding var itemAdded: Bool
   @Environment(\.colorScheme) var colorScheme

//       var body: some View {
//           Text(colorScheme == .dark ? "In dark mode" : "In light mode")
//       }
   
    var body: some View {
        VStack {
         if self.textfieldActive == false {
                 
                 // Delete items
                 Button(action: {
                    deleteItems()
                    print("Trash button pressed")
                 }) {
                  Image(systemName: colorScheme == .light ? "trash.fill" : "trash")
                       .imageScale(.large)
                       .foregroundColor(.red)
                 }.padding()
              }
                 
                 // Add button
         else if textfieldActive == true {
                 Button(action: {
                  if self.textfieldValue == "" {
                     UIApplication.shared.endEditing()
                  } else if self.textfieldValue != "" {
                     addNewItem(itemName: self.$textfieldValue)
                     self.textfieldValue = ""
                     withAnimation { self.itemAdded.toggle() }
                  }
                 }) {
                    Text("Add")
                 }.padding()
              }
               
            
            
                  //Add button
         else if globalVariables.textfieldRowEditMode == true {
                 Button(action: {
                    if self.textfieldValue != "" {

                     withAnimation { self.itemAdded.toggle() }
                    }
                 }) {
                  Image(systemName: colorScheme == .light ? "plus.circle.fill" : "plus.circle")
                     .imageScale(.large)
                     .foregroundColor(.green)

                 }.padding()
              }
              
        }
    }
}
