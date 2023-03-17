//
//  GetJokesOperation.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 17.03.2023.
//

import Foundation

class GetJokesOperation: DataTaskOperation<[Joke]> {
    override var request: URLRequest {
        return GetJokesOperationRequestBuilder(model: self.model as! GetJokesOperationModel.Request).request
    }
}
