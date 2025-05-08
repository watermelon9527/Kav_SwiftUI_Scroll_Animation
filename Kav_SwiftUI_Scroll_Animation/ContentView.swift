//
//  ContentView.swift
//  Kav_SwiftUI_Scroll_Animation
//
//  Created by Neil Chan on 2025/5/7.
//

import SwiftUI

struct ContentView: View {
    // 追蹤當前選中的標籤頁索引
    @State private var selection: Int = 3
    
    var body: some View {
        // 創建標籤視圖
        TabView(selection: $selection) {
            // 首頁標籤
            Tab.init("Home", systemImage: "house", value: 0) {
                Text("Home")
            }
            
            // 圖書館標籤
            Tab.init("Library", systemImage: "books.vertical.fill", value: 1) {
                Text("Library")
            }
            
            // 書店標籤
            Tab.init("Book Store", systemImage: "bag.fill", value: 2) {
                Text("Book Store")
            }
            
            // 搜尋標籤
            Tab.init("Search", systemImage: "magnifyingglass", value: 3) {
                SearchView()
                    .toolbarBackground(.visible, for: .tabBar)
            }
        }
    }
}

#Preview {
    ContentView()
}
