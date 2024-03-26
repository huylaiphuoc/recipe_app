//
//  Middleware.swift
//  recipe-app
//
//  Created by Huy Lai on 26/03/2024.
//

import Foundation

protocol Dependencies {}
protocol Networks: Dependencies {
    init()
}

protocol Service {
    associatedtype Network: CoreNetwork
}

struct NetworkMiddleware<N>: Middleware where N: Networks {
    internal func initializeMiddleware(fromType type: N.Type) -> N {
        N.init()
    }
    
    func call(_ endPoint: (_ network: N) -> ()) {
        endPoint(initializeMiddleware(fromType: N.self))
    }
}

protocol Middleware {
    associatedtype Services
    func initializeMiddleware(fromType type: Services.Type) -> Services
    func call(_ endPoint: (_ service: Services) -> ())
}
