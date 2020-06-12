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
   @State var newItemName: String = ""
   @State var shownInList: Bool
   @State var confirmDeleteItemAlert: Bool = false
   @Binding var textfieldActive: Bool
   @Binding var itemAdded: Bool
   @Binding var showRenameTextfield: Bool
   
   var body: some View {
      HStack {
         
         Text("\(thisItem.position)")
         Text("\(thisItem.wrappedName)")
         
         Button(action: {
            markOffItem(thisItem: self.thisItem)
            if self.textfieldActive == true || self.globalVariables.textfieldRowEditMode == true {
               UIApplication.shared.endEditing()
            }
         }) {

            Image(systemName: thisItem.markedOff ? "checkmark.circle" : "circle")
               .imageScale(.large)
               .foregroundColor(thisItem.markedOff ? .gray : Color("listItemsFont"))
            }
         
         
         
         ZStack(alignment: .leading) {
            if newItemName == "" {
            Text(thisItem.wrappedName)
            }
         
            
         TextField("", text: $newItemName, onEditingChanged: { edit in
               self.globalVariables.textfieldRowEditMode.toggle()
            self.newItemName = self.thisItem.wrappedName
            
// HERE
// Trying to get the state for item names to update, in response to changes in the data

// Fix this
//            if self.newItemName == "" {
//               self.confirmDeleteItemAlert.toggle()
//            }
               
               
            if self.newItemName != "" {
               editName(thisItem: self.thisItem, itemNewName: self.newItemName)
            }
            self.newItemName = ""
            
         }, onCommit: {
            self.itemAdded.toggle()
         })
            .font(.headline)
            .foregroundColor(thisItem.markedOff ? .gray : Color("listItemsFont"))
            .alert(isPresented: $confirmDeleteItemAlert) {
               Alert(title: Text("Delete \(thisItem.wrappedName)?"), primaryButton: .default(Text("Cancel")), secondaryButton: .destructive(Text("Delete"), action: {
                  deleteThisItem(thisItem: self.thisItem)
               }))}
      }
         
         
         
      }
      
   }
}
