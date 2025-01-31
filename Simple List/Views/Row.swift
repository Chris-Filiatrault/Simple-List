//
//  Row.swift
//  Simple List
//
//  Created by Chris Filiatrault on 10/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

import SwiftUI

struct Row: View {
      
   var thisItem: Item
   @State var markedOff: Bool
   @State var position: Int32
   @State var showEditNameView: Bool = false
   @Binding var isEditMode: EditMode
   @EnvironmentObject var globalVariables: GlobalVariableClass
   
   var body: some View {
      HStack {
         
         Button(action: {
            markOffItem(thisItem: self.thisItem)
            if self.globalVariables.textfieldActive == true {
               UIApplication.shared.endEditing()
               self.globalVariables.textfieldActive = false
            }
         }) {
            Image(systemName: thisItem.markedOff ? "checkmark.circle" : "circle")
               .imageScale(.large)
               .foregroundColor(thisItem.markedOff ? .gray : Color("listItemsFont"))
         }
         
         Text(thisItem.wrappedName)
            .foregroundColor(thisItem.markedOff ? .gray : Color("listItemsFont"))
            .font(.headline)
         
         if isEditMode == .active {
            Spacer()
            
            Divider()
            
            Image(systemName: "square.and.pencil")
               .imageScale(.large)
               .foregroundColor(.blue)
               .onTapGesture {
                  self.showEditNameView.toggle()
                  print(self.showEditNameView)
            }
            .sheet(isPresented: self.$showEditNameView){
               EditNameView(thisItem: self.thisItem, showEditNameView: self.$showEditNameView, isEditMode: self.$isEditMode)
                  .environmentObject(self.globalVariables)
            }
         }
      }
   }
}





