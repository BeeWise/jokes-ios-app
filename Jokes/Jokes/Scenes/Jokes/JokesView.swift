//
//  JokesView.swift
//  Jokes
//
//  Created by Dimitri Strauneanu on 17.01.2023.
//

import Foundation
import SwiftUI

protocol JokesDisplayLogic: AnyObject {
    func displayLoadingState()
    func displayNotLoadingState()
    
    func displayItems(viewModel: JokesModels.ItemsPresentation.ViewModel)
}

struct JokesView: View, JokeTextCellDelegate {
    var interactor: JokesBusinessLogic?
    @ObservedObject var displayState: DisplayState
    
    init() {
        let interactor = JokesInteractor()
        let presenter = JokesPresenter()
        let displayer = DisplayState()
        
        presenter.displayer = displayer
        interactor.presenter = presenter
        
        self.interactor = interactor
        self.displayState = displayer
    }
    
    var body: some View {
        VStack {
            if self.displayState.isLoading {
                self.setupLoadingView()
            } else {
                self.setupList()
            }
        }
        .onAppear {
            self.interactor?.shouldFetchItems()
        }
    }
    
    @ViewBuilder func setupLoadingView() -> some View {
        ProgressView()
    }
    
    @ViewBuilder func setupList() -> some View {
        List {
            ForEach(self.displayState.displayedItems) { displayedItem in
                self.setupCell(item: displayedItem)
            }
        }
        
    }
    
    @ViewBuilder func setupCell(item: JokesModels.DisplayedItem) -> some View {
        switch (item.type) {
            case .text: self.setupTextCell(item: item)
            case .qna: self.setupQnaCell(item: item)
        }
    }
    
    @ViewBuilder func setupTextCell(item: JokesModels.DisplayedItem) -> some View {
        if let model = item.model as? JokeTextCell.Model {
            
            JokeTextCell(model: model, delegate: self).onAppear {
                print("Cell did appear: \(model.id)")
            }
        }
        EmptyView()
    }
    
    func jokeTextCellTouchUpInsideButton(cell: JokeTextCell, id: String) {
        print("Action for id: \(id)")
    }
    
    @ViewBuilder func setupQnaCell(item: JokesModels.DisplayedItem) -> some View {
        if let model = item.model as? JokeTextCell.Model {
            JokeTextCell(model: model, delegate: self)
        }
        EmptyView()
    }
}

extension JokesView {
    final class DisplayState: ObservableObject, JokesDisplayLogic {
        @Published var displayedItems: [JokesModels.DisplayedItem] = []
        @Published var isLoading: Bool = false
        
        func displayLoadingState() {
            DispatchQueue.main.async {
                self.isLoading = true
            }
        }
        
        func displayNotLoadingState() {
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
        
        func displayItems(viewModel: JokesModels.ItemsPresentation.ViewModel) {
            DispatchQueue.main.async {
                self.displayedItems = viewModel.displayedItems
            }
        }
    }
}

struct JokesView_Previews: PreviewProvider {
    static var previews: some View {
        var view = JokesView()
        view.displayState = .example
        return view
    }
}

extension JokesView.DisplayState {
    static let example: JokesView.DisplayState = {
        let displayState = JokesView.DisplayState()
        displayState.isLoading = false
        displayState.displayedItems = []
        return displayState
    }()
}
