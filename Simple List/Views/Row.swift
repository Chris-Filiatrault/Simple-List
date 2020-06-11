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
   @State var shownInList: Bool
   @State var confirmDeleteItemAlert: Bool = false
   @Binding var textfieldActive: Bool
   @Binding var itemAdded: Bool
   @Binding var showRenameTextfield: Bool
   
   var body: some View {
      
      HStack(alignment: .center) {
         
         Button(action: {
            markOffItem(thisItem: self.thisItem)
            if self.textfieldActive == true {
               UIApplication.shared.endEditing()
            }
         }) {
            
            Image(systemName: thisItem.markedOff ? "checkmark.circle" : "circle")
               .imageScale(.large)
               .foregroundColor(thisItem.markedOff ? .gray : Color("listItemsFont"))
         }
         
               
               TextField("", text: $itemName, onEditingChanged: { edit in
                  self.globalVariables.textfieldRowEditMode = true
               }, onCommit: {
                  if self.itemName == "" {
                     self.confirmDeleteItemAlert.toggle()
                  }
                  else if self.itemName != "" {
                     editName(thisItem: self.thisItem, itemNewName: self.itemName)
                  }
               })
                  .background(Color(.gray))
                  .font(.headline)
                  .foregroundColor(thisItem.markedOff ? .gray : Color("listItemsFont"))
                  .padding(.vertical, 5)
                  .alert(isPresented: $confirmDeleteItemAlert) {
                     Alert(title: Text("Delete \(thisItem.wrappedName)?"), primaryButton: .default(Text("Cancel")), secondaryButton: .destructive(Text("Delete"), action: {
                        deleteThisItem(thisItem: self.thisItem)
                     }))}
               
            
         }
      }
   }
   

