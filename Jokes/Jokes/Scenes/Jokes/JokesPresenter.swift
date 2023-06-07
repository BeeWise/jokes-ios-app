//
//  JokesPresenter.swift
//  Jokes
//
//  Created by Dimitri Strauneanu on 17.01.2023.
//

import Foundation
import SwiftUI

protocol JokesPresentationLogic {
    func presentLoadingState()
    func presentNotLoadingState()
    
    func presentItems(response: JokesModels.ItemsPresentation.Response)
}

class JokesPresenter: JokesPresentationLogic {
    weak var displayer: JokesDisplayLogic?
    
    func presentLoadingState() {
        self.displayer?.displayLoadingState()
    }
    
    func presentNotLoadingState() {
        self.displayer?.displayNotLoadingState()
    }
    
    func presentItems(response: JokesModels.ItemsPresentation.Response) {
        self.displayer?.displayItems(viewModel: JokesModels.ItemsPresentation.ViewModel(displayedItems: self.displayedItems(items: response.items)))
    }
}

extension JokesPresenter {
    func displayedItems(items: [Joke]) -> [JokesModels.DisplayedItem] {
        return items.compactMap({ self.displayedItem(item: $0) })
    }
    
    func displayedItem(item: Joke) -> JokesModels.DisplayedItem {
        let avatar = self.avatarModel(joke: item)
        let model = JokeTextCell.Model(id: item.uuid, avatar: avatar)
        model.name = JokesStyle.shared.jokeCellModel.nameAttributes(text: item.user?.name)
        model.username = JokesStyle.shared.jokeCellModel.nameAttributes(text: item.user?.username)
        model.text = JokesStyle.shared.jokeCellModel.textAttributes(text: item.text)
        model.time = JokesStyle.shared.jokeCellModel.timeAttributes(text: item.createdAt.description)
        return JokesModels.DisplayedItem(type: .text, model: model)
    }
    
    func avatarModel(joke: Joke) -> UserAvatarView.Model {
        let loadingImage = LoadingImageView.Model()
        if let photoUrl = joke.user?.photo?.url {
            loadingImage.url = URL(string: photoUrl)
        }
        loadingImage.placeholder = JokesStyle.shared.jokeCellModel.avatarPlaceholder()
        let avatar = UserAvatarView.Model(loadingImage: loadingImage)
        avatar.borderRadius = JokesStyle.shared.jokeCellModel.borderRadius()
        return avatar
    }
}
