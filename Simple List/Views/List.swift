//
//  List.swift
//  Simple List
//
//  Created by Chris Filiatrault on 10/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

import SwiftUI

struct ListView: View {
   
   @Binding var isEditMode: EditMode
   @EnvironmentObject var globalVariables: GlobalVariableClass
   
   @FetchRequest(entity: Item.entity(), sortDescriptors: [
      NSSortDescriptor(keyPath: \Item.position, ascending: true)
   ]) var itemsFromFetchRequest: FetchedResults<Item>
   
   var body: some View {
      VStack(spacing: 0) {
         
         List {
            ForEach(self.itemsFromFetchRequest, id: \.self) { item in
               Row(thisItem: item, markedOff: item.markedOff, position: item.position, isEditMode: self.$isEditMode)
                  .background(ListScrollingHelper(proxy: self.globalVariables.scrollingProxy))
            }
            .onMove(perform: move)
            .onDelete(perform: deleteSwipedItem)
            .listRowBackground(Color("listRowBackground").edgesIgnoringSafeArea(.horizontal))
            
            if self.itemsFromFetchRequest.count > 0 {
            Text("")
            .listRowBackground(Color("homeBackground").edgesIgnoringSafeArea(.horizontal))
            }

         }.environment(\.editMode, self.$isEditMode)
         
      }
      .modifier(AdaptsToSoftwareKeyboard())
      
   }
}
