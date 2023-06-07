//
//  JokesModels.swift
//  Jokes
//
//  Created by Dimitri Strauneanu on 17.01.2023.
//

import Foundation
import SwiftUI

enum JokesModels {
    enum ItemType {
        case text
        case qna
    }
    
    struct DisplayedItem: Identifiable {
        internal let id: String = UUID().uuidString
        
        let type: ItemType
        let model: Any
    }
    
    struct ItemsPresentation {
        struct Response {
            let items: [Joke]
        }
        
        struct ViewModel {
            let displayedItems: [DisplayedItem]
        }
    }
}
