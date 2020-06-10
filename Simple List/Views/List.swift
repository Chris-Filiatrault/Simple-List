//
//  List.swift
//  Simple List
//
//  Created by Chris Filiatrault on 10/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

import SwiftUI

struct ListView: View {
   
   @Binding var itemAdded: Bool
   
   @FetchRequest(entity: Item.entity(), sortDescriptors: [
      NSSortDescriptor(keyPath: \Item.position, ascending: false)
   ]) var itemsFromFetchRequest: FetchedResults<Item>
   
   var body: some View {
      VStack {
         
         if itemAdded == true {
            List {
               ForEach(itemsFromFetchRequest, id: \.self) { item in
                  Row(thisItem: item, markedOff: item.markedOff, position: item.position, itemName: item.wrappedName)
               }
               .onMove(perform: move)
               .onDelete(perform: deleteSwipedItem)
               .listRowBackground(Color("listRowBackground").edgesIgnoringSafeArea(.horizontal))
            }
         }
         else if itemAdded == false {
            List {
               ForEach(itemsFromFetchRequest, id: \.self) { item in
                  Row(thisItem: item, markedOff: item.markedOff, position: item.position, itemName: item.wrappedName)
               }
               .onMove(perform: move)
               .onDelete(perform: deleteSwipedItem)
               .listRowBackground(Color("listRowBackground").edgesIgnoringSafeArea(.horizontal))
            }
         }
         
      }.modifier(AdaptsToSoftwareKeyboard())
      
   }
}
