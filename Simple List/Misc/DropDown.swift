//
//  DropDown.swift
//  Simple To-Do List
//
//  Created by Chris Filiatrault on 9/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//


import UIKit
import SwiftUI

public struct DropDownMenu: View {
    @State var expanded: Bool = false

    public var body: some View {
        let marineGreen : Color = Color(UIColor.parse(0x346C7C))
        let whitishGreen: Color = Color(UIColor.parse(0xE7EEEF))
        let genders: [String]   = ["Male", "Female", "Unknown"]
        let width  : CGFloat    = 140

        let menu = VStack(alignment: .leading){
            HStack{
                Text("Gender").fontWeight(.heavy).foregroundColor(whitishGreen)
                Image(systemName: self.expanded ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6).foregroundColor(whitishGreen)
            }.onTapGesture {
               withAnimation {
                  
               self.expanded.toggle()
               }
               
            }.frame(width: width)
            if (self.expanded) {
                ForEach(0 ..< genders.count, id: \.self) {
                    self.menuItem(genders[$0], width, whitishGreen)
                }
            }
        }
        .padding().frame(width: width)
        .background(self.expanded ? marineGreen.opacity(0.9) : marineGreen)
        .animation(.none)
        .onTapGesture {
         withAnimation {
            
            self.expanded.toggle()
         }
        }
        return menu
    }

    private func menuItem(_ gender: String, _ width: CGFloat, _ color: Color) -> some View {
        let padding: CGFloat = 20
        let height : CGFloat = 20

        return VStack {
            Divider().background(color)
            Button(action: {self.expanded.toggle()}){
                Text("\(gender)").frame(height: height).padding([.leading, .trailing], padding)
            }
            .frame(minWidth: width).contentShape(Rectangle())
            .foregroundColor(color)
        }
    }
}


extension UIColor {
    static func parse(_ hex: UInt32, alpha: Double = 1.0) -> UIColor {
        let red   = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue  = CGFloat(hex & 0xFF)/256.0
        return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(alpha))
    }
}
