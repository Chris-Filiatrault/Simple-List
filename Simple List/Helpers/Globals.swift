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
   //@Published var defaults = UserDefaults.standard
   @Published var removeAdsPurchaseRestored: Bool = false
   
   
//   @Published var paidToRemoveAds: Bool {
//      didSet {
//         UserDefaults.standard.set(paidToRemoveAds, forKey: "paidToRemoveAds")
//      }
//   }
//
//   init() {
//      self.paidToRemoveAds = UserDefaults.standard.object(forKey: "paidToRemoveAds") as? Bool ?? true
//   }
   
}
