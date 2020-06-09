//
//  ListView.swift
//  Simple To-Do List
//
//  Created by Chris Filiatrault on 5/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//



import SwiftUI
import CoreData

struct Home: View {
   
   @EnvironmentObject var globalVariables: GlobalVariableClass
   
   @State var textfieldValue: String = ""
   @State var textfieldActive: Bool = false
   @State var itemAdded: Bool = true
   @State var showAddButton: Bool = false
   
   init() {
      
      // To remove all separators in list:
      // UITableView.appearance().separatorStyle = .none
      
      // To remove only extra separators below the list:
      UITableView.appearance().tableFooterView = UIView()
      
      // Remove UITableView background, so it can be programmed using SwiftUI
      UITableView.appearance().backgroundColor = .clear
      
      //UITextField.appearance().backgroundColor = UIColor.blue
   }
   
   var body: some View {
      
      NavigationView {
         VStack {
            
            // ===Enter item textfield===
            ZStack(alignment: .leading) {
               
               if textfieldValue.isEmpty { Text("Enter item...").foregroundColor(Color("textfield")) }
               
               TextField("", text: self.$textfieldValue, onEditingChanged: { changed in
                  self.textfieldActive.toggle()
               }, onCommit: {
                  if self.textfieldValue != "" {
                     addNewItem(itemName: self.$textfieldValue)
                     self.textfieldValue = ""
                     withAnimation { self.itemAdded.toggle() }
                  }
               })
            }
               .padding(8)
               .padding(.horizontal, 3)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color("textfield"), lineWidth: 1.2))
            .background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color("textfieldBackground")))
               .font(.headline)
               .padding()
               .padding(.top, 5)
               
               
               // ===Navigation bar===
               .navigationBarTitle("", displayMode: .inline)
               
               // ===Nav bar items===
               .navigationBarItems(leading:
                  EditButton()
                  .simultaneousGesture(TapGesture().onEnded {
                     withAnimation {
                     self.globalVariables.editModeIsActive.toggle()
                     }
                  })
                     .padding()
                     .offset(x: -5)
                  
                  //.foregroundColor(Color("navBarFont"))
                  ,trailing:
                  TrailingNavBarButtons(textfieldActive: $textfieldActive,
                                        textfieldValue: $textfieldValue,
                                        itemAdded: $itemAdded))
            
            
            //  ===List===
            ListView(itemAdded: $itemAdded)
            
         }
         .background(Color("background").edgesIgnoringSafeArea(.all))
      } // End of NavView
      .navigationViewStyle(StackNavigationViewStyle())
      
   }
}
