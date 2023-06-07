//
//  ApplicationStyle.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 17.03.2023.
//

import SwiftUI

class ApplicationStyle {
    struct colors {
        static func transparent() -> Color { Color.clear }
        static func white() -> Color { Color(hex: 0xFFFFFF) }
        static func black() -> Color { Color(hex: 0x000000) }
        
        static func primary() -> Color { Color(hex: 0x201D2E) }
        static func secondary() -> Color { Color(hex: 0xBC2753) }
        
        static func lightPrimary() -> Color { Color(hex: 0x6FE9ED) }
        static func lightPrimaryShade15() -> Color { Color(hex: 0x6FE9ED4D) }
        
        static func lightSecondary() -> Color { Color(hex: 0xE64E7A) }
        static func lightSecondaryShade15() -> Color { Color(hex: 0xE64E7A4D) }
        
        static func gray() -> Color { Color(hex: 0x697882) }
        static func lightGray() -> Color { Color(hex: 0xE1E8ED) }
        
        static func backgroundColor() -> Color { Color(hex: 0xFFFFFF) }
        
        static func gold() -> Color { Color(hex: 0xFFD700) }
        static func silver() -> Color { Color(hex: 0xC0C0C0) }
        static func bronze() -> Color { Color(hex: 0xCD7F32) }
        
        
        static func neonDarkGreen() -> Color { Color(hex: 0x20CC00) }
        static func neonOrange() -> Color { Color(hex: 0xFBB23F) }
        static func neonPurple() -> Color { Color(hex: 0xE64E7A) }
    }
    
    public struct fonts {
        public static func regular(size: CGFloat) -> Font {
            return Font.custom(names.regular.rawValue, size: size)
        }
        
        public static func bold(size: CGFloat) -> Font {
            return Font.custom(names.bold.rawValue, size: size)
        }
        
        public static func light(size: CGFloat) -> Font {
            return Font.custom(names.light.rawValue, size: size)
        }
        
        public enum names: String, CaseIterable {
            case regular = "Europa-Regular"
            case bold = "Europa-Bold"
            case light = "Europa-Light"
        }
    }
    
    public struct images {
        public static func navigationBarBackgroundImage() -> Image { self.image(named: "navigation_bar_background_image") }
        public static func userAvatarPlaceholderSmallImage() -> Image { self.image(named: "user_avatar_placeholder_small_image") }
        
        
        public static func image(named: String) -> Image {
            return Image(named, bundle: Bundle.main)
        }
    }
}
