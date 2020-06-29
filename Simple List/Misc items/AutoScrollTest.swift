//
//  AutoScrollTest.swift
//  Simple List
//
//  Created by Chris Filiatrault on 28/6/20.
//  Copyright © 2020 Chris Filiatrault. All rights reserved.
//

import SwiftUI

struct AutoScrollTest: View {
    private let scrollingProxy = ListScrollingProxy() // proxy helper

    var body: some View {
        VStack {
            HStack {
                Button(action: { self.scrollingProxy.scrollTo(.top) }) { // < here
                    Image(systemName: "arrow.up.to.line")
                      .padding(.horizontal)
                }
                Button(action: { self.scrollingProxy.scrollTo(.end) }) { // << here
                    Image(systemName: "arrow.down.to.line")
                      .padding(.horizontal)
                }
            }
            Divider()
            List {
                ForEach(0 ..< 200) { i in
                    Text("Item \(i)")
                        .background(ListScrollingHelper(proxy: self.scrollingProxy)) // injection
                }
            }
        }
    }
}
