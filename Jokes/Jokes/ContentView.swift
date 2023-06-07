//
//  ContentView.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 14.03.2023.
//

import SwiftUI

struct ContentView: View {    
    var body: some View {
        VStack {
            ApplicationStyle.images.navigationBarBackgroundImage()
                .foregroundColor(.accentColor)
            Text("Hello, world!").font(.custom(
                "Helvetica-Light",
                fixedSize: 36))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
