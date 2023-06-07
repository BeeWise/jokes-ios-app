//
//  GetJokesOperationRequestBuilder.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 17.03.2023.
//

import Foundation

class GetJokesOperationRequestBuilder: OperationRequestBuilder<GetJokesOperationModel.Request> {
    override var url: String {
        return EndpointsBuilder.shared.jokesEndpoint()
    }

    override var httpMethod: HTTPMethod {
        return .get
    }

    override var queryParameters: [String : Any] {
        var parameters: [String: Any] = [:]
        parameters[Parameters.limit] = self.model.limit
        parameters[Parameters.page] = self.model.page
        return parameters
    }

    override var requiresAuthorization: Bool {
        return true
    }

    private struct Parameters {
        static let
        page = "page",
        limit = "limit"
    }
}
