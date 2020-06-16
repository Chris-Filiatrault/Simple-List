//
//  RemoveAdsView.swift
//  Simple List
//
//  Created by Chris Filiatrault on 16/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

import SwiftUI

struct RemoveAdsView: View {
    
   @Binding var showRemoveAdsView: Bool
   
   var body: some View {

      NavigationView {
      GeometryReader { geometry in

         VStack {

            Text("Remove ads for")

            // ===Buttons===
            HStack(alignment: .center) {

               // Cancel button
               Button(action: {
                  self.showRemoveAdsView.toggle()
               }) {
                  Text("Cancel")
                     .bold()
                     .cornerRadius(20)
                     .font(.subheadline)
                     .frame(minWidth: 50)
               }.contentShape(Rectangle())

               
               // Purchase button
               Button(action: {
                  
                  // Handle purchase here

               }) {
                  Text("Purchase")
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
         .padding(.bottom, geometry.size.height * 0.65)
         .padding()
            }

         .navigationBarTitle("", displayMode: .inline)

         .navigationBarItems(leading:
               Button(action: {
                  self.showRemoveAdsView.toggle()
               }) {
                  Text("Cancel")
                  .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 15))
               }
      )

      .background(Color("background").edgesIgnoringSafeArea(.all))


      }
      .environment(\.horizontalSizeClass, .compact)
   }
}












