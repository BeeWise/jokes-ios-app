//
//  ApplicationConstraints.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 17.03.2023.
//

import Foundation

public class ApplicationConstraints {
    public static func navigationBarHeight() -> CGFloat { 56 }
    public static func tabBarViewHeight() -> CGFloat { 56 }

    public enum constant: CGFloat, CaseIterable {
        case x1 = 1
        case x2 = 2
        case x3 = 3
        case x4 = 4
        case x6 = 6
        case x8 = 8
        case x10 = 10
        case x12 = 12
        case x16 = 16
        case x20 = 20
        case x24 = 24
        case x32 = 32
        case x40 = 40
        case x50 = 50
        case x64 = 64
        case x72 = 72
        case x80 = 80
        case x88 = 88
        case x100 = 100
    }

    public enum multiplier: CGFloat, CaseIterable {
        case x162 = 1.62
        case x150 = 1.5
        case x125 = 1.25
        case x100 = 1
        case x75 = 0.75
        case x62 = 0.62
        case x50 = 0.5
        case x45 = 0.45
        case x38 = 0.38
        case x25 = 0.25
    }
}
