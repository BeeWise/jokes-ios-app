//
//  JokesStyle.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 20.03.2023.
//

import Foundation
import SwiftUI

class JokesStyle {
    static let shared = JokesStyle()
    
    var contentViewModel: ContentViewModel = ContentViewModel()
    var jokeCellModel: JokeCellModel = JokeCellModel()
    
    private init() {
        
    }
    
    struct ContentViewModel {
        func backgroundColor() -> Color { ApplicationStyle.colors.backgroundColor() }
    }
    
    struct JokeCellModel {
        func avatarPlaceholder() -> Image { ApplicationStyle.images.userAvatarPlaceholderSmallImage() }
        
        func borderRadius() -> Double { 25.0 }
        
        func nameAttributes(text: String?) -> AttributedString {
            var attributedString = AttributedString(text ?? "")
            attributedString.font = ApplicationStyle.fonts.bold(size: 17)
            attributedString.foregroundColor = ApplicationStyle.colors.primary()
            return attributedString
        }
        
        func usernameAttributes(text: String?) -> AttributedString {
            var attributedString = AttributedString(text ?? "")
            attributedString.font = ApplicationStyle.fonts.regular(size: 14)
            attributedString.foregroundColor = ApplicationStyle.colors.gray()
            return attributedString
        }
        
        func textAttributes(text: String?) -> AttributedString {
            var attributedString = AttributedString(text ?? "")
            attributedString.font = ApplicationStyle.fonts.regular(size: 17)
            attributedString.foregroundColor = ApplicationStyle.colors.primary()
            return attributedString
        }
        
        func answerAttributes(text: String?) -> AttributedString {
            var attributedString = AttributedString(text ?? "")
            attributedString.font = ApplicationStyle.fonts.regular(size: 17)
            attributedString.foregroundColor = ApplicationStyle.colors.primary()
            return attributedString
        }
        
        func timeAttributes(text: String?) -> AttributedString {
            var attributedString = AttributedString(text ?? "")
            attributedString.font = ApplicationStyle.fonts.regular(size: 13)
            attributedString.foregroundColor = ApplicationStyle.colors.gray()
            return attributedString
        }
    }
}
