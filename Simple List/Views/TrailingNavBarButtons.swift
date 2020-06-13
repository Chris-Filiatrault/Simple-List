//
//  TrailingNavBarButtons.swift
//  Simple List
//
//  Created by Chris Filiatrault on 10/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//


import SwiftUI

struct TrailingNavBarButtons: View {
   
   @FetchRequest(entity: Item.entity(), sortDescriptors: [
      NSSortDescriptor(keyPath: \Item.position, ascending: false)], predicate: NSPredicate(format: "shownInList == true && markedOff == true")) var tickedOffItems: FetchedResults<Item>
   
   @EnvironmentObject var globalVariables: GlobalVariableClass
   
   @Binding var textfieldValue: String
   @State var showNoItemsAlert: Bool = false
   @Environment(\.colorScheme) var colorScheme
   
   
   var body: some View {
      VStack {
         if self.globalVariables.textfieldActive == false && globalVariables.textfieldRowEditMode == false {
            
            HStack {
               
            // Delete items
            Button(action: {
               if self.tickedOffItems.count == 0 {
                  self.showNoItemsAlert = true
               } else if self.tickedOffItems.count > 0 {
                  deleteItems()
               }
               print("Trash button pressed")
            }) {
               Image(systemName: colorScheme == .light ? "trash" : "trash")
                  .imageScale(.large)
                  .foregroundColor(.red)
            }.padding()
               .alert(isPresented: $showNoItemsAlert) {
                  Alert(title: Text("Information"), message: Text("Tick off items in your list to delete them all at once"), dismissButton: .default(Text("Ok")))
            }
         }
         }
            
            
            // Add button
            else if globalVariables.textfieldActive == true && globalVariables.textfieldRowEditMode == false {
               Button(action: {
                  if self.textfieldValue == "" {
                     UIApplication.shared.endEditing()
                  } else if self.textfieldValue != "" {
                     addNewItem(itemName: self.$textfieldValue)
                     self.textfieldValue = ""
                     withAnimation { self.globalVariables.itemAdded.toggle() }
                  }
               }) {
                  Text(self.textfieldValue == "" ? "Done" : "Add")
               }.padding()
            }
               
               
               
            //Rename done button
         else if globalVariables.textfieldActive == false && globalVariables.textfieldRowEditMode == true {
               Button(action: {
                  UIApplication.shared.endEditing()
                  self.globalVariables.textfieldRowEditMode = false
                  
               }) {
                  Text("Done")
                  
               }.padding()
            }
            
         }
      }
}
