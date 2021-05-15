//
//  SizeAdaptor.swift
//  AppAdapter
//
//  Created by Simon on 2021/5/14.
//

import Foundation
import UIKit
/// 屏幕宽度
public let kScreenWidth: CGFloat = UIScreen.main.bounds.width
/// 屏幕高度
public let kScreenHeight: CGFloat = UIScreen.main.bounds.height
/// 屏幕宽高最大值
public let kScreenMax: CGFloat = max(kScreenWidth, kScreenHeight)
/// 状态栏高度
public let kStatusBarHeight: CGFloat = kStatusBarSize().height
/// 导航栏高度
public let kNavBarHeight: CGFloat = 44.0
/// 顶部高度
public let kTopHeight: CGFloat = kStatusBarHeight + kNavBarHeight
/// 底部安全高度
public let kSafeHeight: CGFloat = kBottomSafeHeight()
/// Tabbar 高度
public let kTabBarHeight: CGFloat = kSafeHeight + 49.0
/// 以宽度为基准, 适配比例, 以iPhone6为比例
public let kScale: CGFloat = kScreenWidth / 375.0



// MARK: 函数
/// 动态获取状态栏size
public func kStatusBarSize() -> CGSize {
    if #available(iOS 13, *) {
        let window = UIApplication.shared.windows.first
        return window?.windowScene?.statusBarManager?.statusBarFrame.size ?? CGSize(width: 0.0, height: 0.0)
    } else {
        return UIApplication.shared.statusBarFrame.size
    }
}

public func kBottomSafeHeight() -> CGFloat {
    if #available(iOS 11, *) {
        return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
    }
    return 0.0
}


/// UI 宽高适配,
/// - Parameters:
///   - size: 设计稿尺寸大小
///   - scale: 是否缩放
/// - Returns: 适配后的大小
public func kAdaptor(_ size: CGFloat, scale: Bool = true) -> CGFloat {
    if scale {
        return ceil(size * kScale)
    }
    return size
}
