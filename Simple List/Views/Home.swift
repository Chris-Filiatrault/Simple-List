//
//  Home.swift
//  Simple List
//
//  Created by Chris Filiatrault on 10/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

import SwiftUI
import CoreData

struct Home: View {
   
   @EnvironmentObject var globalVariables: GlobalVariableClass
   
   @State var textfieldValue: String = ""
   @State var showAddButton: Bool = false
   @State var isEditMode: EditMode = .inactive
   
   init() {
      
      // To remove all separators in list:
      //UITableView.appearance().separatorStyle = .none
      
      // To remove only extra separators below the list:
      UITableView.appearance().tableFooterView = UIView()
      
      // Remove UITableView background, so it can be programmed using SwiftUI
      UITableView.appearance().backgroundColor = .clear
      
      //UITextField.appearance().backgroundColor = UIColor.blue
      
      guard let appDelegate =
         UIApplication.shared.delegate as? AppDelegate else {
            return
      }
      
      let managedContext =
         appDelegate.persistentContainer.viewContext
      
      let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Item")
      
      do {
         let fetchReturn = try managedContext.fetch(fetchRequest) as! [Item]
         
         for item in fetchReturn {
            print(item.wrappedName)
         }
         
      }
      catch let error as NSError {
         print("Could not delete. \(error), \(error.userInfo)")
      }
      
   }
   
   
   
   var body: some View {
      
      NavigationView {
         VStack(spacing: 0) {
            
            // ===Enter item textfield===
            ZStack(alignment: .leading) {
               
               if self.textfieldValue.isEmpty {
                  Text("Tap to enter an item...")
                     .foregroundColor(Color("textfield"))
               }
               
               TextField("", text: self.$textfieldValue, onEditingChanged: { changed in
                  withAnimation {
                     print(self.isEditMode)
                     self.globalVariables.textfieldActive.toggle()
                     self.isEditMode = .inactive
                     
                     
                  }
               }, onCommit: {
                  if self.textfieldValue != "" {
                     addNewItem(itemName: self.$textfieldValue)
                     self.textfieldValue = ""
                     withAnimation { self.globalVariables.itemAdded.toggle() }
                  }
               })
            }
            .padding(.horizontal, 5)
            .font(.headline)
            .padding()
            .padding(.top, 5)
            .padding(.vertical, 10)
            .background(Color("listRowBackground"))
               
               
               
               // ===Navigation bar===
               .navigationBarTitle("", displayMode: .inline)
               
               // ===Nav bar items===
               .navigationBarItems(leading:
                  VStack {
                     if self.globalVariables.textfieldActive == false {
                        
                        EditButton()
                           .padding()
                           .offset(x: -5)
                     }
                  }
                  ,trailing:
                  TrailingNavBarButtons(textfieldValue: self.$textfieldValue, isEditMode: self.$isEditMode))
               .environment(\.editMode, self.$isEditMode)
            
            
            //  ===List===
            ListView(isEditMode: self.$isEditMode)
            
            
            if globalVariables.textfieldActive == false {
               AdView()
                  .frame(width: 320, height: 50, alignment: .center)
                  .padding(.top, 5)
            }
            
//            // Use this after the in-app purchase to remove ads has been recorded in UserDefaults
//            if UserDefaults.standard.object(forKey: "purchased") as? Bool ?? nil != true {
//                              AdView()
//                                 .frame(width: 320, height: 50, alignment: .center)
//                                 .padding(.top, 5)
//                           }
            
            
         }
         .background(Color("background").edgesIgnoringSafeArea(.all))
      } // End of NavView
         .navigationViewStyle(StackNavigationViewStyle())
      
      
   }
}
