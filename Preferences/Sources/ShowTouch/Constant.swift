//
//  Constant.swift
//  
//
//  Created by p-x9 on 2023/04/20.
//  
//

import Foundation

enum Constant {
    static let tweakName = "ShowTouch"
    static let preferencePlistPath = "/var/mobile/Library/Preferences/com.p-x9.showtouch.pref.plist"
    static let preferenceChangedNotification = "com.p-x9.showtouch.prefschanged"
}

extension CFNotificationName {
    static let preferenceChanged = CFNotificationName(rawValue: Constant.preferenceChangedNotification as CFString)
}
