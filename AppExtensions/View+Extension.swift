//
//  View+Extension.swift
//  AppExtensions
//
//  Created by Simon on 2021/5/15.
//

import Foundation

// MARK: 坐标
extension UIView {
    /// x
    var x: CGFloat {
        get { return frame.origin.x }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
            
        }
    }
    /// y
    var y: CGFloat {
        get { return frame.origin.y }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }

    
    /// height
    var height: CGFloat {
        get { return frame.size.height }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    /// width
    var width: CGFloat {
        get { return frame.size.width }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width  = newValue
            frame = tempFrame
        }
    }
    /// size
    var size: CGSize {
        get { return frame.size }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size        = newValue
            frame                 = tempFrame
        }
    }
    /// centerX
    var centerX: CGFloat {
        get { return center.x }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x            = newValue
            center                  = tempCenter
        }
    }
    /// centerY
    var centerY: CGFloat {
        get { return center.y }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y            = newValue
            center                  = tempCenter
        }
    }
}

// MARK: 添加圆角
extension UIView {
    /// 四角加圆角
    /// - Parameter cornerSize: cornerSize description
    func addAllCorner(cornerSize: CGSize) {
        self.addCorner(roundingCorners: .allCorners, cornerSize: cornerSize)
    }
    /// 四角加圆角
    /// - Parameter cornerSize: cornerSize description
    func addRoundCorner(radius: CGFloat) {
        self.addCorner(roundingCorners: .allCorners, cornerSize: CGSize(width: radius, height: radius))
    }
    
    /// 指定角加圆角
    /// - Parameters:
    ///   - roundingCorners: roundingCorners description
    ///   - cornerSize: cornerSize description
    func addCorner(roundingCorners: UIRectCorner, cornerSize: CGSize) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: roundingCorners, cornerRadii: cornerSize)
        let cornerLayer = CAShapeLayer()
        cornerLayer.frame = bounds
        cornerLayer.path = path.cgPath
        cornerLayer.shouldRasterize = true
        cornerLayer.rasterizationScale = UIScreen.main.scale
        layer.mask = cornerLayer
    }
}

// MARK: 颜色
extension UIView {
    /// 添加渐变色 startPoint & endPoint设置为(0,0)(1.0,0)代表水平方向渐变,(0,0)(0,1.0)代表竖直方向渐变
    func addGradientColor(colors:[CGColor],startPoint:CGPoint,endPoint:CGPoint) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
            /// 延时0.1秒让进程进入下一个runloop获取到真正的frame（使用约束时也可以获取到真实的frame）
            let colorLayer = CAGradientLayer()
            colorLayer.frame = self.bounds
            colorLayer.startPoint = startPoint
            colorLayer.endPoint = endPoint
            colorLayer.colors = colors
            self.layer.insertSublayer(colorLayer, at: 0)
        })
    }
}

// MARK: 动画
extension UIView {
  
}

// MARK: 视图
extension UIView {
    func removeAllSubviews() {
        while self.subviews.count != 0 {
            self.subviews.last?.removeFromSuperview()
        }
    }
}
