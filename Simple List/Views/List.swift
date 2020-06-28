//
//  List.swift
//  Simple List
//
//  Created by Chris Filiatrault on 10/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

import SwiftUI

struct ListView: View {
   
   @EnvironmentObject var globalVariables: GlobalVariableClass
   @Binding var isEditMode: EditMode
 
   @FetchRequest(entity: Item.entity(), sortDescriptors: [
      NSSortDescriptor(keyPath: \Item.position, ascending: true)]) var itemsFromFetchRequest: FetchedResults<Item>


   var body: some View {
      VStack(spacing: 0) {
         
         if itemsFromFetchRequest.count >= 1 {
            Divider()
         }
//
//         if globalVariables.itemAdded == true {
//            List {
//               ForEach(itemsFromFetchRequest, id: \.self) { item in
//                  VStack(spacing: 0) {
//
//                     Row(thisItem: item, markedOff: item.markedOff, position: item.position, isEditMode: self.$isEditMode)
//
//                  }
//               }
//               .onMove(perform: move)
//               .onDelete(perform: deleteSwipedItem)
//               .listRowBackground(Color("listRowBackground").edgesIgnoringSafeArea(.horizontal))
//            }.environment(\.editMode, self.$isEditMode)
//         }
//
//         else if globalVariables.itemAdded == false {
//           List {
//            ForEach(itemsFromFetchRequest, id: \.self) { item in
//                  VStack(spacing: 0) {
//
//                     Row(thisItem: item, markedOff: item.markedOff, position: item.position, isEditMode: self.$isEditMode)
//
//
//                  }
//               }
//               .onMove(perform: move)
//               .onDelete(perform: deleteSwipedItem)
//               .listRowBackground(Color("listRowBackground").edgesIgnoringSafeArea(.horizontal))
//            }.environment(\.editMode, self.$isEditMode)
//
//         }

         
         
         List {
            ForEach(itemsFromFetchRequest, id: \.self) { item in

                  Row(thisItem: item, markedOff: item.markedOff, position: item.position, isEditMode: self.$isEditMode)
                     .background(ListScrollingHelper(proxy: self.globalVariables.scrollingProxy))

                       
            }
            .onMove(perform: move)
            .onDelete(perform: deleteSwipedItem)
            .listRowBackground(Color("listRowBackground").edgesIgnoringSafeArea(.horizontal))
         }.environment(\.editMode, self.$isEditMode)
         
      }
      .modifier(AdaptsToSoftwareKeyboard())

   }
}


