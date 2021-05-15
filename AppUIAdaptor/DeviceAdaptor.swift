//
//  DeviceAdaptor.swift
//  AppAdapter
//
//  Created by Simon on 2021/5/14.
//

import Foundation
import UIKit

/// 当前app版本号
public let kAppVersion: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
public let kAppBundleId: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as! String
public let kAppName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String

/// 获取设备系统号
public let kIOSVersion: String = UIDevice.current.systemVersion

/// 是否为 iphone
public let kIsIphone = (UIDevice.current.userInterfaceIdiom == .phone)
/// 是否为pad
public let kIsPad = (UIDevice.current.userInterfaceIdiom == .pad)
/// 是否为x系列
public let kIsIphoneXOrMore = (kIsIphone && (kScreenHeight >= 812))
