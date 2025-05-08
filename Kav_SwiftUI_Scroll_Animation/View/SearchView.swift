//
//  Home.swift
//  Kav_SwiftUI_Scroll_Animation
//
//  Created by Neil Chan on 2025/5/7.
//

import SwiftUI

struct SearchView: View {
    // 追蹤當前活動的書籍ID
    @State private var activeID: String? = books.first?.id
    // 追蹤水平滾動的位置
    @State private var scrollPosition: ScrollPosition = .init(idType: String.self)
    // 追蹤是否有任何書籍卡片正在滾動
    @State private var isAnyBookCardScrolled: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            // 背景矩形，使用灰色半透明效果
            Rectangle()
                .fill(.gray.opacity(0.15))
                .ignoresSafeArea()
            
            // 水平滾動視圖
            ScrollView(.horizontal) {
                HStack(spacing: 4) {
                    // 遍歷所有書籍並創建卡片視圖
                    ForEach(books) { book in
                        BookCardView(book: book, size: geometry.size) { isScrolled in
                            isAnyBookCardScrolled = isScrolled
                        }
                        // 設置卡片寬度，考慮邊距
                        .frame(width: geometry.size.width - 30)
                        // 根據是否為當前活動卡片設置堆疊順序
                        .zIndex(activeID == book.id ? 1000 : 1)
                    }
                }
                // 啟用滾動目標佈局
                .scrollTargetLayout()
            }
            // 設置安全區域內邊距
            .safeAreaPadding(15)
            // 設置滾動行為為視圖對齊
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            // 綁定滾動位置
            .scrollPosition($scrollPosition)
            // 當有卡片在滾動時禁用滾動
            .scrollDisabled(isAnyBookCardScrolled)
            // 監聽滾動位置變化，更新活動ID
            .onChange(of: scrollPosition.viewID(type: String.self)) { oldValue, newValue in
                activeID = newValue
            }
            // 隱藏滾動指示器
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    ContentView()
}
