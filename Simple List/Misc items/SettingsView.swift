////
////  SettingsView.swift
////  Simple List
////
////  Created by Chris Filiatrault on 17/6/20.
////  Copyright © 2020 Chris Filiatrault. All rights reserved.
////
//
//import SwiftUI
//
//struct ContentView: View {
//    @ObservedObject var userSettings = UserSettings()
//    
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("PROFILE")) {
//                    TextField("Username", text: $userSettings.username)
//                    Toggle(isOn: $userSettings.isPrivate) {
//                        Text("Private Account")
//                    }
//                    Picker(selection: $userSettings.ringtone, label: Text("Ringtone")) {
//                        ForEach(userSettings.ringtones, id: \.self) { ringtone in
//                            Text(ringtone)
//                        }
//                    }
//                }
//            }
//            .navigationBarTitle("Settings")
//        }
//    }
//}
