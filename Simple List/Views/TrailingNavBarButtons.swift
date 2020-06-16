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
   
   @State var showNoItemsAlert: Bool = false
   @State var confirmDeleteItemsAlert: Bool = false
   @State var showRemoveAdsView: Bool = false
   
   @Binding var textfieldValue: String
   @Binding var isEditMode: EditMode

   @Environment(\.colorScheme) var colorScheme
   
   
   
   var body: some View {
      VStack {
         if self.globalVariables.textfieldActive == false {
            
            HStack {
               
               Button(action: {
                  self.isEditMode = .inactive
                  self.showRemoveAdsView = true
               }) {
                  Image(systemName: "info.circle")
                     .imageScale(.large)
               }
               .sheet(isPresented: self.$showRemoveAdsView){
                  RemoveAdsView(showRemoveAdsView: self.$showRemoveAdsView)
               }
               
               // Delete items
               Button(action: {
                  if self.tickedOffItems.count > 0 {
                     self.confirmDeleteItemsAlert = true
                  }
               }) {
                  Image(systemName: colorScheme == .light ? "trash" : "trash")
                     .imageScale(.large)
                     .foregroundColor(.red)
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
         else if globalVariables.textfieldActive == false {
            Button(action: {
               UIApplication.shared.endEditing()
               
            }) {
               Text("Done")
               
            }.padding()
         }
         
      }
   }
}
