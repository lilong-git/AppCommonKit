//
//  AppLogger.swift
//  AppTools
//
//  Created by Simon on 2021/5/15.
//

import Foundation
import Log

public class DLog {
    private class var instance: Logger {
        get {
            let log = Logger(formatter: Formatter("%@ (%@): %@", .location, .date("YYYY-MM-dd HH:mm:ss:SSS"), .message), theme: .default)
            #if !RELEASE
            log.enabled = true
            #else
            log.enabled = false
            #endif
            return log
        }
    }
    public class func trace(_ items: Any...) {
        DLog.instance.trace(items)
    }
    public class func debug(_ items: Any...) {
        DLog.instance.debug(items)
    }
    public class func info(_ items: Any...) {
        DLog.instance.info(items)
    }
    public class func warning(_ items: Any...) {
        DLog.instance.warning(items)
    }
    public class func error(_ items: Any...) {
        DLog.instance.error(items)
    }
}


