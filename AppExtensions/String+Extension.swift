//
//  String+Extension.swift
//  AppExtensions
//
//  Created by Simon on 2021/5/15.
//

import Foundation
import SwifterSwift

extension String {
    var length:Int { return (self as NSString).length }
        
    var bool:Bool { return (self as NSString).boolValue }
    
    var integer:NSInteger { return (self as NSString).integerValue }
    
    var float:Float { return (self as NSString).floatValue }
    
    var cgFloat:CGFloat { return CGFloat(self.float) }
    
    var double:Double { return (self as NSString).doubleValue }
    
    /// 文件后缀(不带'.')
    var pathExtension:String { return (self as NSString).pathExtension }
    
    /// 文件名(带后缀)
    var lastPathComponent:String { return (self as NSString).lastPathComponent }
    
    /// 文件名(不带后缀)
    var deletingPathExtension:String { return (self as NSString).deletingPathExtension }
    
    /// 去除首尾空格
    var removeSpaceHeadAndTail:String { return trimmingCharacters(in: NSCharacterSet.whitespaces) }
    
    /// 去除首尾换行
    var removeEnterHeadAndTail:String { return trimmingCharacters(in: NSCharacterSet.whitespaces) }
    
    /// 去除首尾空格和换行
    var removeSEHeadAndTail:String { return trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) }
    
    /// 去掉所有空格
    var removespaceAll:String { return replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "　", with: "") }
    
    /// 去除所有换行
    var removeEnterAll:String { return replacingOccurrences(of: "\n\n", with: "\n").replacingOccurrences(of: "\n", with: "\n\n") }
    
    /// 去除所有空格换行
    var removespaceEnterAll:String { return removespaceAll.replacingOccurrences(of: "\n", with: "") }
    
    var readReplaceStr: String {
        /// 过滤掉无用标签
        let str = self.replacingOccurrences(of: "br/", with: "\n")
            .replacingOccurrences(of: "<p>", with: "")
            .replacingOccurrences(of: "</p>", with: "")
            .replacingOccurrences(of: "\n \n", with: "\n\n")
            .replacingOccurrences(of: "\n  \n", with: "\n\n")
            .replacingOccurrences(of: "\n   \n", with: "\n\n")
        
//        let regular = try! NSRegularExpression(pattern: "\n{1,}[ ]{0,}", options: NSRegularExpression.Options.caseInsensitive)
//        str = regular.stringByReplacingMatches(in: str, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: str.length), withTemplate: "\n\t")
        
//        let blankSpaceRegular = try! NSRegularExpression(pattern: "^", options: NSRegularExpression.Options.caseInsensitive)
//        str = blankSpaceRegular.stringByReplacingMatches(in: str, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, str.length), withTemplate: "    ")
        return str
    }
    
    /// 金额格式化
    var amountFmt: String {
        var amount = self
        if amount.isEmpty {
            return "0"
        }
        if !amount.isFloat {
            return "0"
        }
        if amount.contains(",") {
            amount = amount.replace(of: ",", with: "")
        }
        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .decimal
        numberFormatter.roundingMode = .floor  // 不进行四舍五入
        numberFormatter.minimumFractionDigits = 0 // 最小小数位
        numberFormatter.maximumFractionDigits = 2 // 最大小数位
        numberFormatter.minimumIntegerDigits = 1  // 最小整数位
        let dec = NSDecimalNumber(string: amount)
        return numberFormatter.string(from: dec) ?? "0"
    }
    
    /// 是否为整数
    var isInt:Bool {
        
        let scan: Scanner = Scanner(string: self)
        
        var val:Int = 0
        
        return scan.scanInt(&val) && scan.isAtEnd
    }
    
    /// 是否为数字或Float
    var isFloat:Bool {
        
        let scan: Scanner = Scanner(string: self)
        
        var val:Float = 0
        
        return scan.scanFloat(&val) && scan.isAtEnd
    }
    
    /// 是否为空格
    var isSpace:Bool {
        
        if (self == " ") || (self == "　") { return true }
        
        return false
    }
    
    /// 是否为空格或者回车
    var isSpaceOrEnter:Bool {
        
        if isSpace || (self == "\n") { return true }
        
        return false
    }
    
    
    /// 转JSON
    var json: Any? {
        
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
        
        return json
    }
    
    /// 是否包含指定字符串
    func range(_ string: String) -> NSRange {
        
        return (self as NSString).range(of: string)
    }
    
    /// 截取字符串
    func substring(_ range:NSRange) -> String {
        
        return (self as NSString).substring(with: range)
    }
    
    /// 字符串截取(从0开始计数)
    func subString(from: Int, length: Int) -> String {
        if (from >= 0) && (length>0) && (self.count>=(from+length)) {
            let start = self.index(self.startIndex, offsetBy: from)
            let len = self.index(start, offsetBy: length-1)
            let subStr = self[start...len]
            return String(subStr)
        }
        print("数组越界")
        return ""
    }
    /// 处理带中文的字符串
    func addingPercentEncoding(_ characters: CharacterSet = .urlQueryAllowed) -> String {
        
        return (self as NSString).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
    }
    
    /// 正则替换字符
    func replacingCharacters(_ pattern:String, _ template:String) -> String {
        
        do {
            let regularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            
            return regularExpression.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange(location: 0, length: length), withTemplate: template)
        } catch {return self}
    }
    
    /// 正则搜索相关字符位置
    func matches(_ pattern: String) -> [NSTextCheckingResult] {
        
        if isEmpty {return []}
        do {
            let regularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            return regularExpression.matches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange(location: 0, length: length))
        } catch {return []}
    }
    
    /// 计算大小
    func size(_ font:UIFont, _ size:CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) -> CGSize {
        let string: NSString = self as NSString
        return string.boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [.font: font], context: nil).size
    }
    
    /// 检查邮箱格式
    func validateEmail() -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    /// 时间戳转换成时间
    ///
    /// - Parameters:
    ///   - dateInterVal: 需要转的时间戳
    ///   - withDateFormat: 时间格式
    /// - Returns: 返回转换好的时间
    static func changeToDate(_ dateInterVal: Double, _ withDateFormat: String) -> String {
        /// 转换为时间
        let timeInterval:TimeInterval = TimeInterval(dateInterVal)
        let date = Date(timeIntervalSince1970: timeInterval)
        /// 格式输出
        let dformatter = DateFormatter()
        dformatter.dateFormat = withDateFormat
       
        return dformatter.string(from: date)
    }
    
    static let randomStrCharacters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    static func randomStr(len : Int) -> String {
        var ranStr = ""
        for _ in 0..<len {
            let index = Int(arc4random_uniform(UInt32(randomStrCharacters.count)))
            ranStr.append(randomStrCharacters[randomStrCharacters.index(randomStrCharacters.startIndex, offsetBy: index)])
        }
        return ranStr
    }
    
    /// 随机字符
    /// - Parameter length: length description
    /// - Returns: description
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    func formatterNumStr() -> String {
        let number = self.double
        var str = "0"
        
        if number > 100000000000 {
            str =  String(format: "%.1fT", Float(number/1000000000000.0))
        } else if number > 1000000000 {
            str =  String(format: "%.1fB", Float(number/1000000000.0))
        } else if number > 1000000 {
            str =  String(format: "%.1fM", Float(number/1000000.0))
        } else if number > 1000 {
            str =  String(format: "%.1fK", Float(number/1000.0))
        } else {
            str =  String(format: "%zd", self.integer)
        }
        return str
    }
    
    /// 获取字符串绘制的高度
    /// - parameter font        : 要绘制的字体，将会影响行高等
    /// - parameter width       : 绘制的宽度
    /// - returns : 字符串绘制的最大高度
    func getMaxHeight(font:UIFont, width:CGFloat) -> CGFloat {
        // 获取最大的
        let sss = CGSize(width: width, height: CGFloat(MAXFLOAT))
        return getMaxHeight(font: font, rangeRect: sss)
    }

    /// 获取字符串绘制的高度
    ///
    /// - parameter font        : 要绘制的字体，将会影响行高等
    /// - parameter rangeRect   : 绘制的最大范围，类似于最大的画布
    /// - returns : 字符串绘制的最大高度
    func getMaxHeight(font:UIFont, rangeRect rect:CGSize) -> CGFloat {
        // draw option
        let opt:NSStringDrawingOptions = [NSStringDrawingOptions.truncatesLastVisibleLine, NSStringDrawingOptions.usesFontLeading, NSStringDrawingOptions.usesLineFragmentOrigin]
        // str
        let str = NSString(string: self)
        // max size
        let maxSize = rect
        // font
        let attr:[NSAttributedString.Key:Any] = [NSAttributedString.Key.font:font]
        // 计算出来的范围
        let resultRect = str.boundingRect(with: maxSize, options: opt, attributes: attr, context: nil)
        // 返回高度
        return CGFloat(ceil(Double(resultRect.height)))
    }

    /**
     获取字符串的单行宽度,
     有可能会超过屏幕限制
     - parameter font : 要绘制的字体
     */
    func getMaxWidth(font:UIFont) -> CGFloat {
        let opt:NSStringDrawingOptions = [NSStringDrawingOptions.truncatesLastVisibleLine, NSStringDrawingOptions.usesFontLeading, NSStringDrawingOptions.usesLineFragmentOrigin]
        // str
        let str = NSString(string: self)
        // max size
        let maxSize = CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))
        // font
        let attr:[NSAttributedString.Key:Any] = [NSAttributedString.Key.font:font]
        // 计算出来的范围
        let resultRect = str.boundingRect(with: maxSize, options: opt, attributes: attr, context: nil)
        // 返回高度
        return CGFloat(ceil(Double(resultRect.width)))
    }

    /**
     去除左右的空格和换行符
     */
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    /**
     将字符串通过特定的字符串拆分为字符串数组
     - parameter str   : 拆分数组使用的字符串
     - returns : 字符串数组
     */
    func split(string:String) -> [String] {
        return NSString(string: self).components(separatedBy: string)
    }

    /**
     拆分字符串，并获取指定索引的字符串
     - parameter splitStr   : 拆分数组使用的字符串
     - parameter index      : 索引位置
     - parameter defaultStr : 默认字符串
     - returns : 拆分所得字符串
     */
    func strSplitByIndex(splitStr str:String, index:Int, defaultStr:String = "") -> String {
        let aaa = self.split(string:str)
        if index > aaa.count - 1 {
            return defaultStr
        }
        return aaa[index]
    }

    /**
     字符串替换
     - parameter of     : 被替换的字符串
     - parameter with   : 替换使用的字符串
     - returns : 替换后的字符串
     */
    func replace(of: String, with: String) -> String {
        return self.replacingOccurrences(of: of, with: with)
    }

    /**
     判断是否包含，虽然系统提供了方法，这里也只是简单的封装。如果swift再次升级的话，就知道现在做的好处了
     - parameter string : 是否包含的字符串
     - returns : 是否包含
     */
    func has(string:String) -> Bool {
        return self.contains(string)
    }

    /// 将16进制字符串转为Int
    var hexInt:Int {
        get {
            return Int(self, radix: 16) ?? 0
        }
    }
    /// 将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    /// 将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}

