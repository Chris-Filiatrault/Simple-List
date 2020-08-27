//
//  TrailingNavBarButtons.swift
//  Simple List
//
//  Created by Chris Filiatrault on 10/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//


import SwiftUI
import StoreKit

struct ChangingButtons: View {
   
   @FetchRequest(entity: Item.entity(), sortDescriptors: [
      NSSortDescriptor(keyPath: \Item.position, ascending: false)
   ], predicate: NSPredicate(format: "markedOff == true"))
   var tickedOffItems: FetchedResults<Item>
   
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
                        tickedOffItems.count > 1 ? "Delete \(tickedOffItems.count) items?" : "Delete \(tickedOffItems.count) item?"),
                     primaryButton: .default(Text("Cancel")),
                     secondaryButton: .destructive(Text("Delete")) {
                        deleteItems()
                        
                        if UserDefaults.standard.integer(forKey: "syncNumTimesUsed") > 20 && UserDefaults.standard.bool(forKey: "syncShownReviewRequest") != true {
                           SKStoreReviewController.requestReview()
                           UserDefaults.standard.set(true, forKey: "syncShownReviewRequest")
                        }
                     }
                  )
               }
            }
         }
            
            
            // Done/Add button
         else if globalVariables.textfieldActive == true {
            
            Button(action: {
               if self.textfieldValue == "" {
                  UIApplication.shared.endEditing()
                  withAnimation {                        
                     self.globalVariables.textfieldActive = false
                  }
               } else if self.textfieldValue != "" {
                  addNewItem(itemName: self.$textfieldValue)
                  self.textfieldValue = ""
                  self.globalVariables.scrollingProxy.scrollTo(.end)
               }
            }) {
               Text(self.textfieldValue == "" ? "Done" : "Add")
                  .foregroundColor(Color("navBarFont"))
                  .padding()
            }
         }
         
      }
   }
}
