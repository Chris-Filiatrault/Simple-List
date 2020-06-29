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
   @State var showRemoveAdsView: Bool = false
   @State var purchaseMade: Bool = false
   @State var japaneseTextfieldValue: String = ""
   @State var isEditMode: EditMode = .inactive
   
   let standardDarkBlueUIColor: UIColor = UIColor(red: 0/255, green: 10/255, blue: 30/255, alpha: 1)
   
   let itemNames: [String] = ["Zero", "One", "Two", "Three", "Four"]
   let itemPositions: [Int] = [0,1,2,3,4]
   
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
      
      
      
      // Code for initialising with Five test items
      //      resetMOC()
      
      //      let entity = NSEntityDescription.entity(forEntityName: "Item", in: managedContext)!
      //
      //      for position in itemPositions {
      //      let newItem = Item(entity: entity, insertInto: managedContext)
      //      newItem.name = itemNames[position]
      //      newItem.position = Int32(position)
      //      newItem.dateAdded = Date()
      //      newItem.markedOff = false
      //      newItem.id = UUID()
      //      }
      
   }
   
   
   
   var body: some View {
      
      NavigationView {
         VStack(spacing: 0) {

            // TextField
            TextField("Add item", text: self.$textfieldValue, onEditingChanged: { changed in
               withAnimation {
               self.isEditMode = .inactive
               }
               self.globalVariables.textfieldActive.toggle()
            }, onCommit: {
               if self.textfieldValue != "" {
                  addNewItem(itemName: self.$textfieldValue)
                  self.globalVariables.scrollingProxy.scrollTo(.top)
                  self.textfieldValue = ""
               }
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
               .padding()
               
               
               // ===Navigation bar===
               .navigationBarTitle("", displayMode: .inline)
               .background(NavigationConfigurator { nc in
                  nc.navigationBar.barTintColor = self.standardDarkBlueUIColor
               })
               
               // ===Nav bar items===
               .navigationBarItems(leading:
                  HStack {
                     
                     // Edit button
                     VStack {
                        if self.globalVariables.textfieldActive == false {
                           EditButton()
                              .padding()
                              .offset(x: -5)
                              .foregroundColor(Color("navBarFont"))
                        }
                     }
                     
                     Button(action: {
                        resetMOC()
                     }) {
                        Text("Del")
                           .padding()
                           .foregroundColor(Color("navBarFont"))
                     }

                     
                  },trailing:
                  
                  HStack {
                     VStack {
                        if self.globalVariables.textfieldActive == false &&
                           UserDefaults.standard.object(forKey: "purchased") as? Bool ?? nil != true {
                           
                           Button(action: {
                              self.isEditMode = .inactive
                              self.showRemoveAdsView = true
                           }) {
                              Image(systemName: "info.circle")
                                 .imageScale(.large)
                                 .foregroundColor(Color("navBarFont"))
                           }
                           .padding()
                           .sheet(isPresented: self.$showRemoveAdsView){
                              RemoveAdsView(showRemoveAdsView: self.$showRemoveAdsView, purchaseMade: self.$purchaseMade)
                           }
                        }
                     }
                     
                     // Changing buttons
                     ChangingButtons(textfieldValue: self.$textfieldValue, isEditMode: self.$isEditMode)
                  }
            )
               .environment(\.editMode, self.$isEditMode)
            
            
            //  ===List===
            ListView(isEditMode: self.$isEditMode)
            
            
            // ===Ad View===
            if UserDefaults.standard.object(forKey: "purchased") as? Bool ?? nil != true && self.globalVariables.textfieldActive == false {
               AdView()
                  .frame(width: 320, height: 50, alignment: .center)
                  .padding(.top, 5)
            }
            else if UserDefaults.standard.object(forKey: "purchased") as? Bool ?? nil == true {
               // Show nothing
            }
         
         }
         .background(Color("listRowBackground").edgesIgnoringSafeArea(.all))
         .alert(isPresented: self.$purchaseMade) {
            Alert(title: Text("Thanks for your support! 😁"), dismissButton: .default(Text("Done")))
         }
      } // End of NavView
         .navigationViewStyle(StackNavigationViewStyle())
      
      
      
   }
}
