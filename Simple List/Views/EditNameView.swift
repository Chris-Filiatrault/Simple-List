//
//  EditNameView.swift
//  Simple List
//
//  Created by Chris Filiatrault on 13/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.


import SwiftUI

struct EditNameView: View {
   
   @EnvironmentObject var globalVariables: GlobalVariableClass
   var thisItem: Item
   @Binding var showEditNameView: Bool
   @Binding var isEditMode: EditMode
   
   static var focusTextfield: Bool = true
   static var itemName: String = ""
   static var itemNameBinding = Binding<String>(get: { itemName }, set: { itemName = $0 } )
   
   var body: some View {
      
            VStack {
               
               // ===Title===
               Text("Rename Item")
                  .bold()
                  .font(.largeTitle)
                  .padding(.top, 50)
               Divider()
                  .padding(.bottom, 30)
                  .offset(y: -15)
               
               // ===Edit item textfield===
               CustomTextField("", text: EditNameView.itemNameBinding, focusTextfieldCursor: EditNameView.focusTextfield, onCommit: {
                  print("Commit")
                  self.commit()

               }, onBeginEditing: {
                  print("Begin edit")
               })
               .padding(.bottom)
               .environmentObject(globalVariables)
               
               
               // ===Buttons===
               HStack(alignment: .center) {
                  
                  // Cancel button
                  Button(action: {
                     self.showEditNameView.toggle()
                     print(self.showEditNameView)
                  }) {
                     Text("Cancel")
                        .bold()
                        .cornerRadius(20)
                        .font(.subheadline)
                        .frame(minWidth: 50)
                  }.contentShape(Rectangle())
                  
                  // Add button
                  Button(action: {
                     self.commit()
                  }) {
                     
                     
                     Text("Done")
                        .bold()
                        .frame(minWidth: 50)
                        .font(.subheadline)
                        .padding(10)
                        .background(Color("blueButton"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .transition(.scale)
                        .edgesIgnoringSafeArea(.horizontal)
                  }
                  .contentShape(Rectangle())
                  .padding(.leading, 20)
               }
               
               Spacer()
               
            } // End of VStack
            .padding()
            .onAppear {
               EditNameView.focusTextfield = true
               EditNameView.itemName = self.thisItem.wrappedName
            }
            .onDisappear {
               withAnimation {
                  self.isEditMode = .inactive
                  self.showEditNameView = false
               }
            }
            .environment(\.horizontalSizeClass, .compact)
            .background(Color("homeBackground").edgesIgnoringSafeArea(.all))
   }
   
   func commit() {
      if EditNameView.itemName != "" {
         editName(thisItem: self.thisItem, itemNewName: EditNameView.itemName)
         self.showEditNameView.toggle()
         EditNameView.itemName = ""
      }
   }
}









