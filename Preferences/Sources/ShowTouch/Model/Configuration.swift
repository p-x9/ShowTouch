//
//  Configuration.swift
//  
//
//  Created by p-x9 on 2023/04/19.
//  
//

import Foundation
import CoreGraphics

struct Configuration: Codable, Equatable {
    public var isEnabled: Bool

    /// radius of mark on touched point
    public var radius: CGFloat
    /// color of mark on touched point
    public var color: String

    /// offset of mark on touched point
    public var offset: CGPoint = .zero

    /// add a border to the mark of the touched point, or
    public var isBordered: Bool
    /// border color of mark on touched point
    public var borderColor: String
    /// border width of mark on touched point
    public var borderWidth: CGFloat

    /// add shadow to the mark of the touched point, or
    public var isDropShadow: Bool
    /// shadow color of mark on touched point
    public var shadowColor: String
    /// shadow radius of mark on touched point
    public var shadowRadius: CGFloat

    /// show coordinates label or not
    public var isShowLocation: Bool
}

extension Configuration {
    static var `default`: Configuration {
        .init(isEnabled: true,
              radius: 20,
              color: "AA0000FF",
              offset: .init(x: 0, y: -10),
              isBordered: false,
              borderColor: "000000FF",
              borderWidth: 1,
              isDropShadow: true,
              shadowColor: "000000FF",
              shadowRadius: 3,
              isShowLocation: false
        )
    }
}
