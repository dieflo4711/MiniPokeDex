//
//  ContentView.swift
//  MiniPokedex
//
//  Created by diego flores leon on 2023-05-24.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: Tab = .parent
    
    enum Tab {
        case parent
        case kid
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ParentStartView()
                .tabItem {
                    Text("Parent")
                }
                .tag(Tab.parent)
            
            KidStartView()
                .tabItem {
                    Text("Kid")
                }
                .tag(Tab.kid)
        }
        .navigationBarTitle("Join as")
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
