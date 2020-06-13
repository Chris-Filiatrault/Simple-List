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
   @State var showEditNameView: Bool = false
   @State var confirmDeleteItemAlert: Bool = false
   @Binding var showRenameTextfield: Bool
   @State var showCoreDataName: Bool = true
   @Binding var isEditMode: EditMode


   var body: some View {
      
      HStack {
         
      
      HStack {
         
         Button(action: {
            markOffItem(thisItem: self.thisItem)
            if self.globalVariables.textfieldActive == true || self.globalVariables.textfieldRowEditMode == true {
               UIApplication.shared.endEditing()
            }
         }) {
            Image(systemName: thisItem.markedOff ? "checkmark.circle" : "circle")
               .imageScale(.large)
               .foregroundColor(thisItem.markedOff ? .gray : Color("listItemsFont"))
   
         }

         Text(thisItem.wrappedName)
            .foregroundColor(thisItem.markedOff ? .gray : Color("listItemsFont"))
            .font(.headline)
      }
         
         if isEditMode == .active {
         Spacer()
         Divider()
         

         Image(systemName: "square.and.pencil")
               .imageScale(.large)
               .foregroundColor(.blue)
         
         .onTapGesture {
            self.showEditNameView.toggle()
            }
         .sheet(isPresented: self.$showEditNameView){
            EditNameView(thisItem: self.thisItem, showEditNameView: self.$showEditNameView, isEditMode: self.$isEditMode)
            }
         }
         
         
         
      }
      .environment(\.editMode, self.$isEditMode)
   }
}









// TextField("", text: showCoreDataName ? $itemName : $newItemName, onEditingChanged: { edit in
//   self.globalVariables.textfieldRowEditMode.toggle()
//      self.showCoreDataName.toggle()
//
//
//
//   //if self.newItemName != "" {
//      editName(thisItem: self.thisItem, itemNewName: self.newItemName)
//   //}
//
//}, onCommit: {
//
//})         .font(.headline)
//.foregroundColor(thisItem.markedOff ? .gray : Color("listItemsFont"))
//   .alert(isPresented: $confirmDeleteItemAlert) {
//      Alert(title: Text("Delete \(thisItem.wrappedName)?"), primaryButton: .default(Text("Cancel")), secondaryButton: .destructive(Text("Delete"), action: {
//         deleteThisItem(thisItem: self.thisItem)
//      }))}
