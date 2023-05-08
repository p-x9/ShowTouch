//
//  Preferences.swift
//
//
//  Created by p-x9 on 2023/04/19.
//
//

import Foundation
import SwiftUI

@dynamicMemberLookup
class Preferences: ObservableObject {
    @Published var preferences: Configuration = .default

    let url: URL

    let encoder = PropertyListEncoder()

    init(path: String) {
        self.url = URL(fileURLWithPath: path)

        guard let data = try? Data(contentsOf: url) else {
            return
        }
        let decoder = PropertyListDecoder()
        if let preferences = try? decoder.decode(Configuration.self, from: data) {
            self.preferences = preferences
        }
    }

    subscript<T>(dynamicMember keyPath: WritableKeyPath<Configuration, T>) -> Binding<T> {
        .init(
            get: { [unowned self] in
                self.preferences[keyPath: keyPath]
            },
            set: { [unowned self] in
                self.preferences[keyPath: keyPath] = $0
                self.write()
                self.notify()
            }
        )
    }

    func write() {
        guard let data = try? encoder.encode(preferences) else { return }
        try? data.write(to: url)
    }

    func notify() {
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),
                                             .preferenceChanged,
                                             nil, nil, true)
    }
}
