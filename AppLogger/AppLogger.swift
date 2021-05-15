//
//  AppLogger.swift
//  AppTools
//
//  Created by Simon on 2021/5/15.
//

import Foundation
import Log

public let DLog = Logger(formatter: Formatter("%@ (%@): %@", .location, .date("YYYY-MM-dd HH:mm:ss:SSS"), .message), theme: .default)


