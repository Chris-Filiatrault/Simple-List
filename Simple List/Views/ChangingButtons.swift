//
//  TrailingNavBarButtons.swift
//  Simple List
//
//  Created by Chris Filiatrault on 10/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//


import SwiftUI

struct ChangingButtons: View {
   
   @FetchRequest(entity: Item.entity(), sortDescriptors: [
      NSSortDescriptor(keyPath: \Item.position, ascending: false)],
      predicate: NSPredicate(format: "markedOff == true")
   ) var tickedOffItems: FetchedResults<Item>
   
   @EnvironmentObject var globalVariables: GlobalVariableClass
   
   @State var confirmDeleteItemsAlert: Bool = false
   @Binding var textfieldValue: String
   @Binding var isEditMode: EditMode
   
   
   
   var body: some View {
      VStack {
         if self.globalVariables.textfieldActive == false {
            
            HStack {
               
               // Delete items
               Button(action: {
                  if self.tickedOffItems.count > 0 {
                     self.confirmDeleteItemsAlert = true
                  }
               }) {
                  Image(systemName: "trash")
                     .imageScale(.large)
                     .foregroundColor(Color("navBarFont"))
               }
               .padding()
               .alert(isPresented: $confirmDeleteItemsAlert) {
                  Alert(
                     title: Text(
                        tickedOffItems.count > 1 ? "Delete \(tickedOffItems.count) marked off items?" : "Delete \(tickedOffItems.count) item?"),
                     primaryButton: .default(Text("Cancel")),
                     secondaryButton: .destructive(Text("Delete")) { deleteItems() }
                  )
               }
               
            }
         }
            
            
         // Done/Add button
         else if globalVariables.textfieldActive == true {
            HStack {
               
               Button(action: {
                  if self.textfieldValue == "" {
                     UIApplication.shared.endEditing()
                     withAnimation {                        
                     self.globalVariables.textfieldActive = false
                     }
                     print(self.globalVariables.textfieldActive)
                  } else if self.textfieldValue != "" {
                     addNewItem(itemName: self.$textfieldValue)
                     self.textfieldValue = ""
                     self.globalVariables.scrollingProxy.scrollTo(.end)
                  }
               }) {
                  Text(self.textfieldValue == "" ? "Done" : "Add")
                  .foregroundColor(Color("navBarFont"))
               }.padding()
               
               Text("").padding()
            }
         }
            
            
            
            //Rename done button
         else if globalVariables.textfieldActive == false {
            HStack {
               
               Button(action: {
                  UIApplication.shared.endEditing()
                  
               }) {
                  Text("Rename")
                  .foregroundColor(Color("navBarFont"))
                  
               }.padding()
               
               Text("").padding()
            }
         }
         
      }
   }
}
