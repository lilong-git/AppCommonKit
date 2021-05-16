//
//  AttributedString+Extension.swift
//  AppCommonKit-Swift
//
//  Created by long on 2021/5/16.
//

import Foundation

extension NSAttributedString {
    /// 计算size
    func size(_ size:CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) -> CGSize {
        
        return self.boundingRect(with: size, options: [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.usesFontLeading], context: nil).size
    }
    
    /// 扩展拼接
    func add<T:NSAttributedString>(_ string: T) -> NSAttributedString {
        
        let attributedText = NSMutableAttributedString(attributedString: self)
        
        attributedText.append(string)
        
        return attributedText
    }
}
