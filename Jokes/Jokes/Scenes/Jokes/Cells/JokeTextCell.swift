//
//  JokeTextCell.swift
//  Jokes
//
//  Created by Dimitri Strauneanu on 17.01.2023.
//

import Foundation
import SwiftUI

protocol JokeTextCellDelegate {
    func jokeTextCellTouchUpInsideButton(cell: JokeTextCell, id: String)
}

struct JokeTextCell: View {
    @ObservedObject var model: Model
    var delegate: JokeTextCellDelegate?
    
    init(model: Model, delegate: JokeTextCellDelegate? = nil) {
        self.model = model
        self.delegate = delegate
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                self.setupUserAvatar()
                VStack(alignment: .leading) {
                    self.setupName()
                    self.setupUsername()
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            self.setupButton()
            self.setupTime()
        }
        .frame(maxWidth: .infinity)
        
    }
    
    func setupUserAvatar() -> some View {
        UserAvatarView(model: self.model.avatar).frame(width: 50, height: 50)
    }
    
    @ViewBuilder func setupName() -> some View {
        Text(self.model.name)
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    @ViewBuilder func setupUsername() -> some View {
        Text(self.model.username)
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    @ViewBuilder func setupButton() -> some View {
        Button {
            self.delegate?.jokeTextCellTouchUpInsideButton(cell: self, id: self.model.id)
        } label: {
            Text(self.model.text)
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
    }
    
    @ViewBuilder func setupTime() -> some View {
        Text(self.model.time)
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

extension JokeTextCell {
    class Model: ObservableObject {
        @Published var id: String
        @Published var name: AttributedString = AttributedString()
        @Published var username: AttributedString = AttributedString()
        
        @Published var text: AttributedString = AttributedString()
        @Published var time: AttributedString = AttributedString()
        
        @Published var avatar: UserAvatarView.Model
        
        init(id: String, avatar: UserAvatarView.Model) {
            self.id = id
            self.avatar = avatar
        }
    }
}

struct JokeTextCell_Previews: PreviewProvider {
    static var previews: some View {
        return JokeTextCell(model: .example)
    }
}

extension JokeTextCell.Model {
    static let example: JokeTextCell.Model = {
        let loadingImage = LoadingImageView.Model()
        loadingImage.url = URL(string: "https://picsum.photos/200/300")
        loadingImage.placeholder = ApplicationStyle.images.userAvatarPlaceholderSmallImage()
        let avatar = UserAvatarView.Model(loadingImage: loadingImage)
        let model = JokeTextCell.Model(id: "uuid", avatar: avatar)
        model.name = JokesStyle.shared.jokeCellModel.nameAttributes(text: "item.user?.name")
        model.username = JokesStyle.shared.jokeCellModel.nameAttributes(text: "item.user?.username")
        model.text = JokesStyle.shared.jokeCellModel.textAttributes(text: "item.text")
        model.time = JokesStyle.shared.jokeCellModel.timeAttributes(text: "item.createdAt")
        return model
    }()
}
