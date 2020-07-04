//
//  EditNameView.swift
//  Simple List
//
//  Created by Chris Filiatrault on 13/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.


import SwiftUI

struct EditNameView: View {
   
   var thisItem: Item
   @State var newName: String = ""
   @Binding var showEditNameView: Bool
   @Binding var isEditMode: EditMode
   
   var body: some View {
      
      NavigationView {
         GeometryReader { geometry in
            VStack {
               
               // VStack is for applying modifiers to all three Text() views
               VStack {
                  Text("Rename ")
                     + Text("\(self.thisItem.wrappedName)")
                        .bold()
                     + Text(" to:")
                  
               }
               .font(.title)
               .fixedSize(horizontal: false, vertical: true)
               
               
               // ===Enter item textfield===
               TextField("Enter new name...", text: self.$newName, onCommit: {
                  if self.newName != "" {
                     editName(thisItem: self.thisItem, itemNewName: self.newName)
                     self.showEditNameView.toggle()
                     self.newName = ""
                  }
                  print(self.showEditNameView)
               })
                  .textFieldStyle(RoundedBorderTextFieldStyle())
                  .padding(5)
                  .cornerRadius(5)
                  .padding(.bottom, 10)
               
               
               // ===Buttons===
               HStack(alignment: .center) {
                  
                  // Cancel button
                  Button(action: {
                     self.showEditNameView = false
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
                     if self.newName != "" {
                        editName(thisItem: self.thisItem, itemNewName: self.newName)
                        self.newName = ""
                        //                     self.isEditMode = .inactive
                        self.showEditNameView = false
                     }
                  }) {
                     Text("Rename")
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
            }
            .padding(.bottom, geometry.size.height * 0.55)
            .padding()
            .onDisappear {
               withAnimation {
                  self.isEditMode = .inactive
               }
            }
         }
            
         
         // === Nav bar items ===
         .navigationBarTitle("", displayMode: .inline)
         .navigationBarItems(leading:
            Button(action: {
               self.showEditNameView.toggle()
               print(self.showEditNameView)
            }) {
               Text("Cancel")
                  .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 15))
            }
         )
         
      }
      .environment(\.horizontalSizeClass, .compact)
   }
}









