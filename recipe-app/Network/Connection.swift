//
//  Connection.swift
//  recipe-app
//
//  Created by Huy Lai on 26/03/2024.
//

import Foundation
import Moya
import Alamofire

enum Expected<T, err> {
    case success(T)
    case error(err)
}

enum CodeableResponse<T, err> {
    case success(T)
    case error(err)
}

protocol CoreNetwork: TargetType {
    associatedtype Param: RawRepresentable where Param.RawValue: StringProtocol
}

extension CoreNetwork {
    var baseURL: URL {
        return Constant.baseURL
    }
    
    var sampleData: Data {
        return Data()
    }

    var validationType: ValidationType {
        return .successCodes
    }
}

extension TargetType {
    static var make: Connection<Self> {
        return Connection<Self>()
    }
}

struct CSessionManager {
    static let shared: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        return Alamofire.Session(configuration: configuration)
    }()
}

struct Connection<N> where N: TargetType {
    @discardableResult
    func request<C>(node: N, model: C.Type, path: String? = nil, codable: @escaping (CodeableResponse<C, Error>) -> Void) -> Cancellable where C: Codable {
        return getProvider().request(node) { request in
            switch request {
            case .success(let response):
                do {
                    _ = try response.filterSuccessfulStatusAndRedirectCodes()
                    let message = try response.mapObject(model, path: path)
                    codable(CodeableResponse.success(message))
                } catch {
                    break
                }
            case .failure(let failure):
                codable(CodeableResponse.error(failure))
            }
        }
    }
    
    private func getProvider() -> MoyaProvider<N> {
        return MoyaProvider<N>(stubClosure: { (_: N) -> Moya.StubBehavior in return .never }, session: CSessionManager.shared, plugins: [NetworkLoggerPlugin()])
    }
}

extension Response {
    func mapObject<T: Codable>(_ type: T.Type, path: String? = nil) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: try getJsonData(path))
        } catch {
            debugPrint(error)
            throw MoyaError.jsonMapping(self)
        }
    }
    
    private func getJsonData(_ path: String? = nil) throws -> Data {
        do {
            var jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            if let path = path {
                guard let specificObject = jsonObject.value(forKeyPath: path) else {
                    throw MoyaError.jsonMapping(self)
                }
                jsonObject = specificObject as AnyObject
            }
            return try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
        } catch {
            print(error)
            throw MoyaError.jsonMapping(self)
        }
    }
}
