//
//  BookCardView.swift
//  Kav_SwiftUI_Scroll_Animation
//
//  Created by Neil Chan on 2025/5/7.
//

import SwiftUI

struct BookCardView: View {
    // 書籍資料和視圖尺寸參數
    var book: Book
    var size: CGSize
    // 回調函數，用於通知父視圖滾動狀態
    var isScrolled: (Bool) -> ()
    // 父視圖的水平內邊距
    var parentHorizontalPadding: CGFloat = 15
    
    // 滾動追蹤的狀態屬性
    @State private var scrollProperties: ScrollGeometry = .init(
        contentOffset: .zero,      // 當前滾動位置
        contentSize: .zero,        // 內容總大小
        contentInsets: .init(),    // 內容內邊距
        containerSize: .zero       // 容器視圖大小
    )
    // 追蹤滾動位置的狀態
    @State private var scrollPosition: ScrollPosition = .init()
    // 追蹤頁面是否已滾動的狀態
    @State private var isPageScrolled: Bool = false
    
    var body: some View {
        // 創建垂直滾動視圖
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 14) {
                // 頂部卡片視圖，佔據90%的垂直空間
                TopCardView()
                    .containerRelativeFrame(.vertical) { value, _ in value * 0.9}
                
                // 其他文字內容區域
                OtherTextContents()
                    .padding(.horizontal, 15)
                    .frame(maxWidth: size.width - (parentHorizontalPadding * 2))
                    .padding(.bottom, 50)
            }
            // 根據滾動進度調整水平內邊距
            .padding(.horizontal, -parentHorizontalPadding * scrollProperties.topInsetProgress)
        }
        // 將滾動位置綁定到狀態
        .scrollPosition($scrollPosition)
        // 禁用滾動裁剪以實現平滑動畫
        .scrollClipDisabled()
        // 監聽滾動幾何變化
        .onScrollGeometryChange(for: ScrollGeometry.self, of: {
            $0
        }, action: { oldValue, newValue in
            scrollProperties = newValue
            // 當偏移量大於0時更新滾動狀態
            isPageScrolled = newValue.offsetY > 0
        })
        // 隱藏滾動指示器
        .scrollIndicators(.hidden)
        // 設置自定義滾動行為
        .scrollTargetBehavior(BookScrollEnd(topInset: scrollProperties.contentInsets.top))
        // 通知父視圖滾動狀態變化
        .onChange(of: isPageScrolled, { oldValue, newValue in
            isScrolled(newValue)
        })
        .background{
            // 帶圓角的背景
            UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 15)
                .fill(.background)
                .ignoresSafeArea(.all, edges: .bottom)
                // 根據滾動偏移量調整背景位置
                .offset(y: scrollProperties.offsetY > 0 ? 0 : -scrollProperties.offsetY)
        }
    }
    
    // 頂部卡片視圖的實現
    func TopCardView() -> some View {
        VStack(spacing: 15) {
            // 固定頂部導航欄
            FixedHeaderView()
            
            // 書籍縮略圖
            Image(book.thumbnail)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 10)
            
            // 書籍標題
            Text(book.title)
                .seriafText(.title2, weight: .bold)
            
            // 作者按鈕
            Button {
                // 按鈕動作待實現
            } label: {
                HStack(spacing: 6) {
                    Text(book.author)
                    Image(systemName: "chevron.right")
                        .font(.callout)
                }
            }
            .padding(.top, -5)
            
            // 評分標籤
            Label(book.rating, systemImage: "star.fill")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
            
            // 書籍信息卡片
            VStack(alignment: .leading, spacing: 4) {
                // 書籍類型標題
                HStack(spacing: 4){
                    Text("Book")
                        .fontWeight(.semibold)
                    Image(systemName: "info.circle")
                        .font(.caption)
                }
                
                // 頁數信息
                Text("45 pages")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                // 操作按鈕組
                HStack(spacing: 10) {
                    // 試讀按鈕
                    Button {
                        // 按鈕動作待實現
                    } label: {
                        Label("Sample", systemImage: "book.ppages")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical,5)
                    }
                    .tint(.white.opacity(0.2))
                    
                    // 購買按鈕
                    Button {
                        // 按鈕動作待實現
                    } label: {
                        Text("Get")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical,5)
                    }
                    .foregroundStyle(.black)
                    .tint(.white.opacity(0.2))
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 5)
            }
            .padding(15)
            .background(.white.opacity(0.2), in: .rect(cornerRadius: 15))
        }
        // 設置前景色為白色
        .foregroundStyle(.white)
        .padding(15)
        // 設置卡片寬度，考慮父視圖的內邊距
        .frame(maxWidth: size.width - (parentHorizontalPadding * 2))
        .frame(maxWidth: .infinity)
        .background {
            // 使用書籍顏色創建漸變背景
            Rectangle()
                .fill(book.color.gradient)
        }
        // 裁剪視圖形狀
        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 0,bottomTrailingRadius: 0, topTrailingRadius: 15))
    }
    
    // 其他文字內容區域的實現
    func OtherTextContents() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            // 出版商信息
            Text("From the publosher")
                .seriafText(.title3, weight: .semibold)
            
            // 出版商描述文字
            Text(dummyText)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
                .lineLimit(5)
            
            // 系統需求標題
            Text("Requiments")
                .seriafText(.title3, weight: .semibold)
                .padding(.top, 15)
            
            // 系統需求詳細信息
            VStack(alignment: .leading, spacing: 4) {
                Text("Apple Books")
                Text("Requires iOS 12 or macOS 10.14 or later")
                    .foregroundStyle(.secondary)
                
                Text("iBooks")
                    .padding(.top, 5)
                
                Text("Requires iBooks 3 and iOS 4.3 or later")
                    .foregroundStyle(.secondary)
                
                // 版本信息
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
    
    // 固定頂部導航欄的實現
    func FixedHeaderView() -> some View {
        HStack(spacing: 10) {
            // 關閉按鈕
            Button {
                // 按鈕動作待實現
            } label: {
                Image(systemName: "xmark.circle.fill")
            }
            
            Spacer()
            
            // 添加按鈕
            Button {
                // 按鈕動作待實現
            } label: {
                Image(systemName: "plus.circle.fill")
            }
            
            // 更多選項按鈕
            Button {
                // 按鈕動作待實現
            } label: {
                Image(systemName: "ellipsis.circle.fill")
            }
        }
        .buttonStyle(.plain)
        .font(.title)
        .foregroundStyle(.white, .white.tertiary)
        // 根據滾動進度調整水平內邊距，實現漸變效果
        .padding(.horizontal, -parentHorizontalPadding * scrollProperties.topInsetProgress)
        // 當滾動偏移量小於20時保持在原位，大於20時跟隨滾動
        .offset(y: scrollProperties.offsetY < 20 ? 0 : scrollProperties.offsetY - 20)
        // 確保頂部導航欄始終顯示在最上層
        .zIndex(1000)
    }
}

extension View {
    func seriafText(_ font: Font, weight: Font.Weight) -> some View {
        self.font(font)
            .fontWeight(weight)
            .fontDesign(.serif)
    }
}

// 為滾動幾何添加計算屬性的擴展
extension ScrollGeometry {
    // 計算包含內邊距的總垂直偏移量
    var offsetY: CGFloat {
        contentOffset.y + contentInsets.top
    }
    
    // 計算頂部內邊距的進度（0到1之間）
    var topInsetProgress: CGFloat {
        guard contentInsets.top > 0 else { return 0 }
        return max(min(offsetY / contentInsets.top, 1), 0)
    }
}

// 書籍視圖的自定義滾動行為
struct BookScrollEnd: ScrollTargetBehavior {
    var topInset: CGFloat
    // 根據位置更新滾動目標
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        // 當滾動到頂部內邊距以上時重置到頂部
        if target.rect.minY < topInset {
            target.rect.origin = .zero
        }
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
