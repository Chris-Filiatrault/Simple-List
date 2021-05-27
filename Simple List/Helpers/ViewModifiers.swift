//
//  ViewModifiers.swift
//  Simple List
//
//  Created by Chris Filiatrault on 27/8/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

import SwiftUI


// For adding the cross circle next to the textfield
struct ClearButton: ViewModifier {

   @EnvironmentObject var globalVariables: GlobalVariableClass
   @Binding var itemInTextfield: String
   
   public func body(content: Content) -> some View {
      HStack(alignment: .center) {
         content
         if !itemInTextfield.isEmpty {
            Button(action: {
               self.itemInTextfield = ""
            }) {
               Image(systemName: "multiply.circle")
                  .imageScale(.large)
                  .foregroundColor(Color(.gray))
                  .padding(15)
            }
            .padding(.trailing, 10)
         }
      }
   }
}


struct MainBlueButton: ViewModifier {
    func body(content: Content) -> some View {
        content
         
         .frame(minWidth: 50)
         .padding(10)
         .background(LinearGradient(gradient: Gradient(colors: [Color("darkBlue"), Color("lightBlue")]), startPoint: .leading, endPoint: .trailing))
         .foregroundColor(.white)
         .cornerRadius(40)
         .padding(.horizontal, 3)

    }
}
