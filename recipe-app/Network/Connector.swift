//
//  Connector.swift
//  recipe-app
//
//  Created by Huy Lai on 26/03/2024.
//

import Foundation
import Moya

struct Connector<N, S> where N: CoreNetwork, S: Codable {
    @discardableResult
    func doConnect(point: N, path: String? = nil, response: @escaping (Expected<S, BaseErrorModel>) -> ()) -> Cancellable? {
        return N.make.request(node: point, model: S.self, path: path) { (result) in
            switch result {
            case .success(let rsp):
                response(Expected.success(rsp))
            case .error(let error):
                let errorMessage = error.localizedDescription
                
                    // Handle errors
                    response(Expected.error(BaseErrorModel(message: errorMessage)))
            }
        }
    }
}
