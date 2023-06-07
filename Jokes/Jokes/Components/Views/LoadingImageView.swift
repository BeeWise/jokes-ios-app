//
//  LoadingImageView.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 26.04.2023.
//

import Foundation
import SwiftUI

struct LoadingImageView: View {
    @ObservedObject var model: Model
    
    var body: some View {
        return self.setupImageView()
    }
    
    func setupImageView() -> some View {
        VStack {
            if let url = self.model.url {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    self.setupProgressView()
                }
            } else if let placeholder = self.model.placeholder {
                placeholder.resizable().aspectRatio(contentMode: .fit)
            }
        }.cornerRadius(self.model.borderRadius)
    }
    
    func setupProgressView() -> some View {
        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: self.model.activityIndicatorColor))
    }
}

extension LoadingImageView {
    class Model: ObservableObject {
        @Published var url: URL?
        @Published var placeholder: Image?
        
        @Published var activityIndicatorColor: Color = ApplicationStyle.colors.lightGray()
        @Published var borderRadius: Double = 0
    }
}


struct LoadingImageView_Previews: PreviewProvider {
    static var previews: some View {
        return LoadingImageView(model: .example)
    }
}

extension LoadingImageView.Model {
    static let example: LoadingImageView.Model = {
        let model = LoadingImageView.Model()
        model.url = URL(string: "https://picsum.photos/200/300")
        model.activityIndicatorColor = .red
        model.borderRadius = 0
        model.placeholder = ApplicationStyle.images.userAvatarPlaceholderSmallImage()
        return model
    }()
}
