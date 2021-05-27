//
//  HostingController.swift
//  Simple List
//
//  Created by Chris Filiatrault on 29/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

import SwiftUI


// For setting status bar to light
class HostingController<Home>: UIHostingController<Home> where Home : View {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
