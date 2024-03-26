//
//  HomeRequest.swift
//  recipe-app
//
//  Created by Huy Lai on 26/03/2024.
//

import Foundation

struct HomeRequest: Networks {}

extension HomeRequest: HomeInterface {
    typealias Network = HomeDescription

    func fetchRecipeData(expected: @escaping (Expected<[RecipeModel], BaseErrorModel>) -> Void) {
        let call = Connector<Network, [RecipeModel]>()
        call.doConnect(point: .fetchRecipeData) { (response) in
            expected(response)
        }
    }
}
