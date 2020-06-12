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
 
   @Published var textfieldRowValue: String = ""
   @Published var textfieldRowEditMode: Bool = false
   @Published var itemID: UUID = UUID()
   @Published var blurList: Bool = false
   
   
}
