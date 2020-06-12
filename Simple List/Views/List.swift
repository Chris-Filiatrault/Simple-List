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

   @State private var showRenameTextfield = false
   @State private var alertInput = ""
   @Binding var itemAdded: Bool
   @Binding var textfieldActive: Bool

   @FetchRequest(entity: Item.entity(), sortDescriptors: [
      NSSortDescriptor(keyPath: \Item.position, ascending: false)], predicate: NSPredicate(format: "shownInList == true")) var itemsFromFetchRequest: FetchedResults<Item>



   var body: some View {
      VStack(spacing: 0) {

         if itemAdded == true {
            List {
               ForEach(itemsFromFetchRequest, id: \.self) { item in
                  VStack(spacing: 0) {

                     Row(thisItem: item, markedOff: item.markedOff, position: item.position, itemName: item.wrappedName,
                         shownInList: item.shownInList, textfieldActive: self.$textfieldActive, itemAdded: self.$itemAdded,
                         showRenameTextfield: self.$showRenameTextfield)
                  }
               }
               .onMove(perform: move)
               .onDelete(perform: deleteSwipedItem)
               .listRowBackground(Color("listRowBackground").edgesIgnoringSafeArea(.horizontal))
            }
            .environment(\.defaultMinListRowHeight, 20)
         }

         else if itemAdded == false {
           List {
               ForEach(itemsFromFetchRequest, id: \.self) { item in
                  VStack(spacing: 0) {

                     Row(thisItem: item, markedOff: item.markedOff, position: item.position, itemName: item.wrappedName,
                         shownInList: item.shownInList, textfieldActive: self.$textfieldActive, itemAdded: self.$itemAdded,
                         showRenameTextfield: self.$showRenameTextfield)
                  }
               }

               .onMove(perform: move)
               .onDelete(perform: deleteSwipedItem)
               .listRowBackground(Color("listRowBackground").edgesIgnoringSafeArea(.horizontal))
            }
           .environment(\.defaultMinListRowHeight, 20)

         }

      }
      .modifier(AdaptsToSoftwareKeyboard())

   }
}


