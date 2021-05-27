//
//  UserSettings.swift
//  Simple List
//
//  Created by Chris Filiatrault on 17/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

//
//import SwiftUI
//import Foundation
//import Combine
//
//// ADD THIS TO ANY VIEW TO MAKE USER SETTINGS AVAILABLE
////@EnvironmentObject var userSettings: UserSettings
//
//
//class UserSettings: ObservableObject {
//   
//   @Published var paidToRemoveAds: Bool {
//      didSet {
//         UserDefaults.standard.set(paidToRemoveAds, forKey: "paidToRemoveAds")
//      }
//   }
//    
//    init() {
//      self.paidToRemoveAds = UserDefaults.standard.object(forKey: "paidToRemoveAds") as? Bool ?? false
//    }
//   
//}




//
//import SwiftUI
//import Foundation
//import Combine
//
//class UserSettings: ObservableObject {
//    @Published var username: String {
//        didSet {
//            UserDefaults.standard.set(username, forKey: "username")
//        }
//    }
//
//    @Published var isPrivate: Bool {
//        didSet {
//            UserDefaults.standard.set(isPrivate, forKey: "isAccountPrivate")
//        }
//    }
//
//    @Published var ringtone: String {
//        didSet {
//            UserDefaults.standard.set(ringtone, forKey: "ringtone")
//        }
//    }
//
//    public var ringtones = ["Chimes", "Signal", "Waves"]
//
//    init() {
//        self.username = UserDefaults.standard.object(forKey: "username") as? String ?? ""
//        self.isPrivate = UserDefaults.standard.object(forKey: "isAccountPrivate") as? Bool ?? true
//        self.ringtone = UserDefaults.standard.object(forKey: "ringtone") as? String ?? "Chimes"
//    }
//}
//
