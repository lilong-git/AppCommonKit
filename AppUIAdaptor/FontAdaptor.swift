//
//  FontAdaptor.swift
//  AppAdapter
//
//  Created by Simon on 2021/5/14.
//

import Foundation
import UIKit

/// 字体大小适配
/// - Parameters:
///   - size: 设计稿字体大小
///   - scale: 是否缩放
/// - Returns: 适配后的字体大小
public func kFontSize(_ size: CGFloat, scale: Bool = false) -> CGFloat {
    if scale {
        return ceil(size * kScale)
    }
    return size
}


public func kSysFont(_ size: CGFloat, _ weight: UIFont.Weight = .regular) -> UIFont {
    return UIFont.systemFont(ofSize: kFontSize(size), weight: weight)
}

public func kBoldFont(_ size: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: kFontSize(size))
}
