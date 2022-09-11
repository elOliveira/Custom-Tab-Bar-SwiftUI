//
//  ContentView.swift
//  CustomTabBar
//
//  Created by cit on 11/09/22.
//

import SwiftUI

struct Home: View {
    @State var selectedTab = "house"

    var body: some View {

        ZStack(alignment: .bottom,content: {
            Color("colorBackgroundTabBar")
                .ignoresSafeArea()
            // Custom TAB BAR
            CustomTabBar(selectedTab: $selectedTab)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
