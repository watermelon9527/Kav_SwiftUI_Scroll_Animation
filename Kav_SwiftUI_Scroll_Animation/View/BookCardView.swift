//
//  BookCardView.swift
//  Kav_SwiftUI_Scroll_Animation
//
//  Created by Neil Chan on 2025/5/7.
//

import SwiftUI

struct BookCardView: View {
    // 接收書籍資料和視圖尺寸作為參數
    var book: Book
    var size: CGSize
    
    var body: some View {
        // 創建垂直滾動視圖
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 14) {
                // 頂部卡片視圖，佔據90%的垂直空間
                TopCardView()
                    .containerRelativeFrame(.vertical) { value, _ in value * 0.9}
                
                // 其他文字內容區域
                OtherTextContents()
            }
        }.background{
            // 設置背景為圓角矩形，只有上方有圓角
            UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 15)
                .fill(.background)
                .ignoresSafeArea(.all, edges: .bottom)
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
    }
}

// 擴展 View 協議，添加自定義文字樣式修飾器
extension View {
    func seriafText(_ font: Font, weight: Font.Weight) -> some View {
        self.font(font)
            .fontWeight(weight)
            .fontDesign(.serif)
    }
}

// 預覽視圖
#Preview {
    GeometryReader { geometry in
        BookCardView(book: books[0], size: geometry.size)
    }
    .padding(.horizontal,15)
    .background(.gray.opacity(0.15))
}

