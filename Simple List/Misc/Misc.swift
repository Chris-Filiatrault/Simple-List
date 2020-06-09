//
//  ContentView.swift
//  Simple To-Do List
//
//  Created by Chris Filiatrault on 5/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//





//   @State var textfieldValue: String = ""
//
//   @FetchRequest(entity: Item.entity(), sortDescriptors: [
//      NSSortDescriptor(keyPath: \Item.name, ascending: true)
//   ]) var itemsFromFetchRequest: FetchedResults<Item>
//
//
   
//
//   init() {
//      fetchRequest = FetchRequest<Item>(entity: Item.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
//      ])
//
//   }
//
   
//   var body: some View {
//
//      VStack(alignment: .leading) {
//
//      // ===Enter item textfield===
//      TextField("Add item", text: self.$textfieldValue, onCommit: {
//         if self.textfieldValue != "" {
//            addNewItem(itemName: self.$textfieldValue)
//            self.textfieldValue = ""
//         }
//      })
////         self.globalVariables.itemInTextfield = ""
//         .textFieldStyle(RoundedBorderTextFieldStyle())
//         .background(Color(.white))
//         //.padding(20)
//         .padding(.vertical, 10)
//
//
//
//
//         // ===List of items without categories===
////         List(itemsFromFetchRequest, id: \.self) { item in
////            Row(thisItem: item)
////         }
////
//
//
//         ScrollView {
//            VStack(alignment: .leading, spacing: 0) {
//
//            ForEach(itemsFromFetchRequest, id: \.self) { item in
//               Row(thisItem: item)
//                  .padding(.vertical, 3)
//               }
//            }
//         }
//
//                  //   .onDelete(perform: deleteSwipedItem)
//              //    .listRowBackground(Color(.white))
//
//            //.background(Color("listBackground"))
//
//
//
//
//
//
//      } // End of VStack
//      .padding()
//
//    }
  


//import SwiftUI
//import CoreData
//
//struct ItemList: View {
//
//
//   @EnvironmentObject var globalVariables: GlobalVariableClass
//   @State var showMoreOptions: Bool = false
//   var fetchRequest: FetchRequest<Item>
//   var categoriesFetchRequest: FetchRequest<Category>
//   var thisList: ListOfItems
//
//   init(listFromHomePage: ListOfItems) {
//
//      thisList = listFromHomePage
//
//      let originPredicate = NSPredicate(format: "origin = %@", thisList)
//      let inListPredicate = NSPredicate(format: "addedToAList == true")
//      let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [originPredicate, inListPredicate])
//
//      fetchRequest = FetchRequest<Item>(entity: Item.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
//      ], predicate: compoundPredicate)
//
//      categoriesFetchRequest = FetchRequest<Category>(entity: Category.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
//      ])
//
//   }
//
//
//   var body: some View {
//
//      VStack(spacing: 0) {
//
//         // ===Enter item textfield===
//         TextField("Add item", text: self.$globalVariables.itemInTextfield, onEditingChanged: { changed in
//            self.globalVariables.catalogueShown = true
//         }, onCommit: {
//            if self.globalVariables.itemInTextfield != "" {
//               addNewItem(itemName: self.$globalVariables.itemInTextfield, listOrigin: self.thisList)
//
//               self.globalVariables.itemInTextfield = ""
//            }
//            self.globalVariables.itemInTextfield = ""
//         })
//            .textFieldStyle(RoundedBorderTextFieldStyle())
//            .background(Color(.white))
//            .padding(20)
//            .padding(.vertical, 2)
//
//
//            // ===Navigation bar===
//            .navigationBarTitle(thisList.wrappedName)
//
//
//            .navigationBarItems(trailing:
//               HStack {
//
//                  if globalVariables.catalogueShown == false {
//
//
//                     // Remove ticked off items button
//                     Button(action: {
//                        removeTickedItemsFromList(listOrigin: self.thisList)
//                     }) {
//                        Image(systemName: "checkmark")
//                           .imageScale(.large)
//                           .foregroundColor(Color("navBarFont"))
//                           .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 5))
//                     }.padding(.vertical, 10)
//
//
//                     // More options
//                     Button(action: {
//                        self.showMoreOptions.toggle()
//                     }) {
//                        Image(systemName: "ellipsis.circle")
//                           .imageScale(.large)
//                           .foregroundColor(Color("navBarFont"))
//                           .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
//                     }.padding(.vertical, 10)
//                        .sheet(isPresented: self.$showMoreOptions){
//                           MoreOptions()
//                     }
//                  }
//
//
//                     // Done button
//                  else if globalVariables.catalogueShown == true && globalVariables.itemInTextfield.count == 0 {
//                     Button(action: {
//                        withAnimation {
//                           UIApplication.shared.endEditing()
//                           self.globalVariables.catalogueShown = false
//                        }
//                     }) {
//                        Text("Done")
//                           .font(.headline)
//                           .foregroundColor(Color("navBarFont"))
//                     }
//                  }
//
//                     // Add button
//                  else if globalVariables.catalogueShown == true && globalVariables.itemInTextfield.count > 0 {
//                     Button(action: {
//                        UIApplication.shared.endEditing()
//                        if self.globalVariables.itemInTextfield != "" {
//                           addNewItem(itemName: self.$globalVariables.itemInTextfield, listOrigin: self.thisList)
//                           self.globalVariables.itemInTextfield = ""
//                        }
//                        self.globalVariables.itemInTextfield = ""
//                     }) {
//                        Text("Add")
//                           .font(.headline)
//                           .foregroundColor(Color("navBarFont"))
//                     }
//                  }
//
//
//            })
//
//
//         //            // ===List of items without categories===
//         //            if globalVariables.catalogueShown == false {
//         //
//         //               List {
//         //                  ForEach(fetchRequest.wrappedValue, id: \.self) { item in
//         //                     ItemRow(thisList: self.thisList, thisItem: item, itemInListMarkedOff: item.markedOff, thisItemQuantity: item.quantity)
//         //                     }
//         //                        //   .onDelete(perform: deleteSwipedItem)
//         //                        .listRowBackground(Color(.white))
//         //                  }
//         //                  .background(Color("listBackground"))
//         //
//         //            }
//
//
//
//         // ===List of items with categories===
//         if globalVariables.catalogueShown == false {
//
//            ScrollView {
//               VStack(alignment: .leading, spacing: 0) {
//                  ForEach(categoriesFetchRequest.wrappedValue, id: \.self) { category in
//                     ItemCategory(listFromHomePage: self.thisList, categoryFromItemList: category)
//                        .background(Color("listBackground"))
//
//                  }
//               }
//            }
//         }
//
//
//
//         // ===Catalogue===
//         else if globalVariables.catalogueShown == true {
//            Catalogue(passedInList: thisList, filter: globalVariables.itemInTextfield)
//
//         }
//         //.resignKeyboardOnDragGesture()
//      }
//      .background(Color("listBackground"))
//      .modifier(AdaptsToSoftwareKeyboard())
//      .edgesIgnoringSafeArea(.horizontal)
//
//      .onDisappear() {
//         self.globalVariables.itemInTextfield = ""
//      }
//      .onAppear() {
//         self.globalVariables.catalogueShown = false
//      }
//
//
//
//   }// End of body
//}
//





// PLACE INSIDE THE LISTVIEW INIT FUNCTION FOR TESTING THE DRAG AND DROP FUNCTION
//
//guard let appDelegate =
//   UIApplication.shared.delegate as? AppDelegate
//   else {
//      return
//}
//
//let managedContext =
//   appDelegate.persistentContainer.viewContext
//
//let entity = NSEntityDescription.entity(forEntityName: "Item", in: managedContext)!
//
//let names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
//for index in 1...10 {
//   let newItem = Item(entity: entity, insertInto: managedContext)
//   newItem.name = names[index - 1]
//   newItem.dateAdded = Date()
//   newItem.markedOff = false
//   newItem.id = UUID()
//   newItem.position = Double(index)


        
//         TextField("", text: $itemName, onEditingChanged: { edit in
//            self.globalVariables.editMode = true
//            self.globalVariables.itemID = self.thisItem.id ?? UUID()
//         }, onCommit: {
//            editName(thisItem: self.thisItem, itemNewName: self.itemName)
//            print("Commit")
//            self.globalVariables.editMode = false
//         })
//         Button(action: {
//            self.markedOff.toggle()
//         }) {
//            Text(thisItem.wrappedName)
//         }
//         .font(.headline)
//         .foregroundColor(thisItem.markedOff ? .gray : Color("listItemsFont"))
//         .strikethrough(thisItem.markedOff, color: .gray)
//
