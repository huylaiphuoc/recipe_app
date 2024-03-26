//
//  HomeInterface.swift
//  recipe-app
//
//  Created by Huy Lai on 26/03/2024.
//

import Foundation
import Moya

protocol HomeInterface: Service {
    func fetchRecipeData(expected: @escaping (Expected<[RecipeModel], BaseErrorModel>) -> Void)
}

enum HomeDescription {
    case fetchRecipeData
}

extension HomeDescription: CoreNetwork {
    internal enum Param: String {
        case param
    }

    var path: String {
        return "recipes.json"
    }

    var method: Moya.Method {
        return .get
    }

    var task: Moya.Task {
        return .requestParameters(parameters: [:], encoding: URLEncoding.default)
    }

    var headers: [String: String]? {
        [:]
    }
}
