//
//  TransparentBlurView.swift
//  Kav_SwiftUI_Scroll_Animation
//
//  Created by Neil Chan on 2025/5/8.
//

import SwiftUI

// 透明模糊視圖的 SwiftUI 包裝器
struct TransparentBlurView: UIViewRepresentable {
    // 創建自定義模糊視圖
    func makeUIView(context: Context) -> CustomBlurView {
        return CustomBlurView(effect: .init(style: .systemUltraThinMaterial))
    }
    
    // 更新視圖（目前未實現）
    func updateUIView(_ uiView: CustomBlurView, context: Context) {
        
    }
}

// 自定義模糊視圖類
class CustomBlurView: UIVisualEffectView {
    init(effect: UIBlurEffect) {
        super.init(effect: effect)
        
        setup()
    }
    
    // 設置視圖
    func setup() {
        removeAllFilters()
        
        // 註冊界面風格變化通知
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (self: Self, _) in
            DispatchQueue.main.async {
                self.removeAllFilters()
            }
        }
    }
    
    // 移除所有過濾器效果
    func removeAllFilters() {
        if let filterLayer = layer.sublayers?.first  {
            filterLayer.filters = []
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
