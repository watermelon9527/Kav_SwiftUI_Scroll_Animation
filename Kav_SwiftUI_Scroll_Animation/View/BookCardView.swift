//
//  BookCardView.swift
//  Kav_SwiftUI_Scroll_Animation
//
//  Created by Neil Chan on 2025/5/7.
//

// BookCardView.swift - 書籍卡片視圖
// 這個視圖用於顯示書籍的詳細信息，包含滾動動畫效果

import SwiftUI

struct BookCardView: View {
    // 書籍數據模型
    var book: Book
    // 父視圖的水平內邊距
    var parentHorizontalPadding: CGFloat = 15
    // 視圖尺寸
    var size: CGSize
    // 滾動狀態回調函數
    var isScrolled: (Bool) -> ()
    
    /// 滾動動畫相關屬性
    @State private var scrollProperties: ScrollGeometry = .init(
        contentOffset: .zero,
        contentSize: .zero,
        contentInsets: .init(),
        containerSize: .zero
    )
    // 滾動位置狀態
    @State private var scrollPosition: ScrollPosition = .init()
    // 頁面是否已滾動狀態
    @State private var isPageScrolled: Bool = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 15) {
                TopCardView()
                    .containerRelativeFrame(.vertical) { value, _ in
                        value * 0.9
                    }
                
                OtherTextContents()
                    .padding(.horizontal, 15)
                    .frame(maxWidth: size.width - (parentHorizontalPadding * 2))
                    .padding(.bottom, 50)
            }
            // 實現滾動時的縮放效果，通過負向縮放水平內邊距
            .padding(.horizontal, -parentHorizontalPadding * scrollProperties.topInsetProgress)
        }
        // 綁定滾動位置
        .scrollPosition($scrollPosition)
        // 禁用滾動裁剪
        .scrollClipDisabled()
        // 監聽滾動幾何變化
        .onScrollGeometryChange(for: ScrollGeometry.self, of: {
            $0
        }, action: { oldValue, newValue in
            scrollProperties = newValue
            isPageScrolled = newValue.offsetY > 0
        })
        // 隱藏滾動指示器
        .scrollIndicators(.hidden)
        // 設置滾動目標行為
        .scrollTargetBehavior(BookScrollEnd(topInset: scrollProperties.contentInsets.top))
        // 監聽頁面滾動狀態變化
        .onChange(of: isPageScrolled, { oldValue, newValue in
            isScrolled(newValue)
        })
        .background {
            UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 15)
                .fill(.background)
                .ignoresSafeArea(.all, edges: .bottom)
                .offset(y: scrollProperties.offsetY > 0 ? 0 : -scrollProperties.offsetY)
                .padding(.horizontal, -parentHorizontalPadding * scrollProperties.topInsetProgress)
        }
    }
    /// 頂部卡片視圖
    func TopCardView() -> some View {
        VStack(spacing: 15) {
            FixedHeaderView()
            
            Image(book.thumbnail)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 10)
            
            Text(book.title)
                .serifText(.title2, weight: .bold)
            
            Button {
                
            } label: {
                HStack(spacing: 6) {
                    Text(book.author)
                    
                    Image(systemName: "chevron.right")
                        .font(.callout)
                }
            }
            .padding(.top, -5)
            
            Label(book.rating, systemImage: "star.fill")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Text("Book")
                        .fontWeight(.semibold)
                    
                    Image(systemName: "info.circle")
                        .font(.caption)
                }
                
                Text("45 Pages")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 10) {
                    Button {
                        
                    } label: {
                        Label("Sample", systemImage: "book.pages")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 5)
                    }
                    .tint(.white.opacity(0.2))
                    
                    Button {
                        
                    } label: {
                        Text("Get")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 5)
                    }
                    .foregroundStyle(.black)
                    .tint(.white)
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 5)
            }
            .padding(15)
            .background(.white.opacity(0.2), in: .rect(cornerRadius: 15))
        }
        .foregroundStyle(.white)
        .padding(15)
        .frame(maxWidth: size.width - (parentHorizontalPadding * 2))
        .frame(maxWidth: .infinity)
        .background {
            Rectangle()
                .fill(book.color.gradient)
        }
        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 15))
    }
    
    /// 其他書籍文本內容
    func OtherTextContents() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("From the Publisher")
                .serifText(.title3, weight: .semibold)
            
            Text(dummyText)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
                .lineLimit(5)
            
            Text("Requirements")
                .serifText(.title3, weight: .semibold)
                .padding(.top, 15)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Apple Books")
                
                Text("Requires iOS 12 or macOS 10.14 or later")
                    .foregroundStyle(.secondary)
                
                Text("iBooks")
                    .padding(.top, 5)
                
                Text("Requires iBooks 3 and iOS 4.3 or later")
                    .foregroundStyle(.secondary)
                
                Text("Versions")
                    .font(.title3)
                    .fontDesign(.serif)
                    .fontWeight(.semibold)
                    .padding(.top, 25)
                
                Text("Updated Mar 16 2022")
                    .foregroundStyle(.secondary)
            }
            .padding(.top, 5)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
    }
    
    func FixedHeaderView() -> some View {
        HStack(spacing: 10) {
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    scrollPosition.scrollTo(edge: .top)
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
            }
            
            Spacer()

            Button {
                
            } label: {
                Image(systemName: "plus.circle.fill")
            }
            
            Button {
                
            } label: {
                Image(systemName: "ellipsis.circle.fill")
            }
        }
        .buttonStyle(.plain)
        .font(.title)
        .foregroundStyle(.white, .white.tertiary)
        .background {
            GeometryReader { geometry in
                TransparentBlurView()
                    .frame(height: scrollProperties.contentInsets.top + 50)
                    .blur(radius: 10, opaque: false)
                    .frame(height: geometry.size.height, alignment: .bottom)
            }
            .opacity(scrollProperties.topInsetProgress)
        }
        .padding(.horizontal, -parentHorizontalPadding * scrollProperties.topInsetProgress)
        .offset(y: scrollProperties.offsetY < 20 ? 0 : scrollProperties.offsetY - 20)
        .zIndex(1000)
    }
}

#Preview {
    GeometryReader { geometry in
        BookCardView(book: books[0], size: geometry.size) { _ in
            
        }
        .padding(.horizontal, 15)
    }
    .background(.gray.opacity(0.15))
}

// 自定義滾動目標行為
struct BookScrollEnd: ScrollTargetBehavior {
    var topInset: CGFloat
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        if target.rect.minY < topInset {
            target.rect.origin = .zero
        }
    }
}

// ScrollGeometry 擴展
extension ScrollGeometry {
    // 計算垂直偏移量
    var offsetY: CGFloat {
        contentOffset.y + contentInsets.top
    }
    
    // 計算頂部內邊距進度
    var topInsetProgress: CGFloat {
        guard contentInsets.top > 0 else { return 0 }
        // 計算滾動進度：0 表示初始位置，1 表示已滾動到頂部
        return max(min(offsetY / contentInsets.top, 1), 0)
    }
}

// View 擴展：添加襯線字體樣式
extension View {
    func serifText(_ font: Font, weight: Font.Weight) -> some View {
        self
            .font(font)
            .fontWeight(weight)
            .fontDesign(.serif)
    }
}
