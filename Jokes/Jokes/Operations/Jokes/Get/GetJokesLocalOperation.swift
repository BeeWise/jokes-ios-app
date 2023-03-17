//
//  GetJokesLocalOperation.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 17.03.2023.
//

import Foundation

class GetJokesLocalOperation: LocalDataTaskOperation<[Joke]> {
    var shouldFail: Bool = false
    var delay: Int = Int.random(in: 1000...3000)
    var count: Int = Int.random(in: 1...10) > 7 ? 0 : Int.random(in: 15...45)
    
    override func main() {
        if self.shouldCancelOperation() {
            return
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(self.delay)) {
            if self.shouldCancelOperation() {
                return
            }
            if self.shouldFail {
                self.noDataAvailableErrorBlock()
            } else {
                let model = self.model as! GetJokesOperationModel.Request
                self.successfulResultBlock(value: self.jokes(count: self.count), pageCount: model.page, itemsPerPage: model.limit)
            }
        }
    }
    
    private func jokes(count: Int) -> [Joke] {
        var jokes: [Joke] = []
        for i in 0 ..< count {
            jokes.append(self.joke(uuid: String(i)))
        }
        return jokes
    }
    
    private func joke(uuid: String) -> Joke {
        let joke = Joke(uuid: uuid)
        return joke
    }
}
