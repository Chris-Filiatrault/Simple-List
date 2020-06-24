//
//  ErrorMessage.swift
//  Simple List
//
//  Created by Chris Filiatrault on 23/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

import SwiftUI

struct ErrorMessage: View {
    var body: some View {
        // Make this error message into something cute
      GeometryReader { geometry in
         VStack(alignment: .leading) {
            
         
      Text("Oops! An error occurred 😵")
         .font(.title)
         .padding(.vertical)
         
         Text("Please ensure you're connected to the internet and try again.")
            .font(.headline)
            .padding(.vertical)
      
         Text("If the problem persists, please contact the developer Chris Filiatrault at:\n\ncf-developer@hotmail.com")
            .font(.headline)
            .padding(.vertical)
            
         }
         Spacer(minLength: geometry.size.height * 0.25)
         
      }.padding()
    }
}
