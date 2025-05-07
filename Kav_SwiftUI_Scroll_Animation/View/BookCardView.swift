//
//  BookCardView.swift
//  Kav_SwiftUI_Scroll_Animation
//
//  Created by Neil Chan on 2025/5/7.
//

import SwiftUI

struct BookCardView: View {
    var book: Book
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 14) {
                TopCardView()
                
            }
            
        }
        
    }
    
    func TopCardView() -> some View {
        VStack(spacing: 15) {
            FixedHeaderView()
            
            Image(book.thumbnail)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 10)
            
            Text(book.title)
                .seriafText(.title2, weight: .bold)
            

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
                
            
        }
        .foregroundStyle(.white)
        .background {
            Rectangle()
                .fill(book.color.gradient)
            
        }
    }
    
    func FixedHeaderView() -> some View {
        HStack(spacing: 10) {
            Button {
                
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
        }.buttonStyle(.plain)
            .font(.title)
            .foregroundStyle(.white, .white.tertiary)
        
    }
}
extension View {
    func seriafText(_ font: Font, weight: Font.Weight) -> some View {
        self.font(font)
            .fontWeight(weight)
            .fontDesign(.serif)
    }
}
#Preview {
    BookCardView(book: books[0])
}

