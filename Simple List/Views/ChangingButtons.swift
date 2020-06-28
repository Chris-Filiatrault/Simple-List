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
      NSSortDescriptor(keyPath: \Item.position, ascending: false)]) var tickedOffItems: FetchedResults<Item>
   
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
//                     .foregroundColor(.red)
               }
               .padding()
               .alert(isPresented: $confirmDeleteItemsAlert) {
                  Alert(
                     title: Text(
                        tickedOffItems.count > 1 ? "Delete \(tickedOffItems.count) items?" : "Delete \(tickedOffItems.count) item?"),
                     primaryButton: .default(Text("Cancel")),
                     secondaryButton: .destructive(Text("Delete")) { deleteItems() }
                  )
               }
               
            }
         }
            
            
            // Add button
         else if globalVariables.textfieldActive == true {
            HStack {
               
               Button(action: {
                  if self.textfieldValue == "" {
                     self.globalVariables.scrollingProxy.scrollTo(.point(point: CGPoint(x: 50, y: 50)))
                     UIApplication.shared.endEditing()
                  } else if self.textfieldValue != "" {
                     addNewItem(itemName: self.$textfieldValue)
                     self.textfieldValue = ""
                     withAnimation { self.globalVariables.itemAdded.toggle() }
                  }
               }) {
                  Text(self.textfieldValue == "" ? "Done" : "Add")
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
                  Text("Done")
                  
               }.padding()
               
               Text("").padding()
            }
         }
         
      }
   }
}
