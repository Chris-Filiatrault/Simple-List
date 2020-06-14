//
//  Globals.swift
//  Simple List
//
//  Created by Chris Filiatrault on 10/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

import SwiftUI
import CoreData

// ADD THIS TO ANY VIEW TO MAKE GLOBAL VARIABLES AVAILABLE
//@EnvironmentObject var globalVariables: GlobalVariableClass

class GlobalVariableClass: ObservableObject {
 

   @Published var textfieldActive: Bool = false
   @Published var itemAdded: Bool = true // for refreshing list state
   @Published var itemID: UUID = UUID()
   @Published var blurList: Bool = false
   
   
   
}
