//
//  UserAvatarView.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 26.04.2023.
//

import Foundation
import SwiftUI

protocol UserAvatarViewDelegate {
    func userAvatarViewOnPress()
}

struct UserAvatarView: View {
    @ObservedObject var model: Model
    
    
    var body: some View {
        self.setupContent()
    }
    
    func setupContent() -> some View {
        VStack {
            self.setupImageView()
        }
        .disabled(self.model.isDisabled)
        .onTapGesture {
            // TODO: Add action
            print("On tap!")
        }
        .cornerRadius(self.model.borderRadius)
        .overlay(
            RoundedRectangle(cornerRadius: self.model.borderRadius)
                .stroke(self.model.borderColor, lineWidth: self.model.borderWidth)
        )
    }
    
    func setupImageView() -> some View {
        return LoadingImageView(model: self.model.loadingImage)
    }
}

extension UserAvatarView {
    class Model: ObservableObject {
        @Published var isDisabled = false
        @Published var backgroundColor: Color = .white
        @Published var borderColor: Color = .white
        @Published var borderWidth = 0.0
        @Published var borderRadius = 0.0
        @Published var loadingImage: LoadingImageView.Model
        
        init(loadingImage: LoadingImageView.Model) {
            self.loadingImage = loadingImage
        }
    }
}

struct UserAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        return UserAvatarView(model: .example)
    }
}

extension UserAvatarView.Model {
    static let example: UserAvatarView.Model = {
        let loadingImage = LoadingImageView.Model()
        loadingImage.url = URL(string: "https://picsum.photos/200/300")
        loadingImage.activityIndicatorColor = .red
        loadingImage.borderRadius = 0
        loadingImage.placeholder = ApplicationStyle.images.userAvatarPlaceholderSmallImage()
        
        let model = UserAvatarView.Model(loadingImage: loadingImage)
        model.isDisabled = false
        model.backgroundColor = .yellow
        model.borderWidth = 10
        model.borderColor = .red
        model.borderRadius = 75
        return model
    }()
}
