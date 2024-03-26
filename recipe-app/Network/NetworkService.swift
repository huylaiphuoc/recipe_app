//
//  NetworkService.swift
//  recipe-app
//
//  Created by Huy Lai on 26/03/2024.
//

import Foundation
import Alamofire

struct NetworkService {
    init() {
        startNetworkReachabilityObserver()
    }
    static var shared = NetworkService()
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
}

extension NetworkService {
    func startNetworkReachabilityObserver() {
        reachabilityManager?.startListening(onUpdatePerforming: { status in
            switch status {
            case .notReachable:
                print("The network is not reachable")
            case .unknown:
                print("It is unknown whether the network is reachable")
            case .reachable(.ethernetOrWiFi), .reachable(.cellular):
                print("The network is reachable over the WiFi connection")
            }
        })
    }

    func hasInternetConnection() -> Bool {
        return reachabilityManager != nil && (reachabilityManager?.isReachable)!
    }
}
