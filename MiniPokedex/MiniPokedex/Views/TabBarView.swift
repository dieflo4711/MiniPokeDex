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
                    Image(systemName: "person.fill")
                    Text("Parent")
                        .foregroundColor(.brown)
                }
                .tag(Tab.parent)
            
            KidStartView()
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("Kid")
                        .foregroundColor(.brown)
                }
                .tag(Tab.kid)
        }
        .tint(.white)
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor(Color.blue)
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color.white.opacity(0.5))
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

