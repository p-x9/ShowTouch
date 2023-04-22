//
//  Binding+.swift
//  
//
//  Created by p-x9 on 2023/04/20.
//  
//

import SwiftUI

extension Binding where Value == String {
    var color: Binding<CGColor> {
        .init(
            get: {
                .color(rgba: wrappedValue)
            },
            set: {
                wrappedValue = $0.rgbaString
            }
        )
    }
}

extension Binding where Value == CGFloat {
    static let numberFormatter = NumberFormatter()

    var string: Binding<String> {
        .init(
            get: {
                "\(wrappedValue)"
            },
            set: {
                guard let n = Double($0) else {
                    return
                }
                wrappedValue = CGFloat(n)
            }
        )
    }
}
