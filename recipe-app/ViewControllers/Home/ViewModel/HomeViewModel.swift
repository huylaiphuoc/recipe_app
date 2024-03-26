//
//  HomeViewModel.swift
//  recipe-app
//
//  Created by Huy Lai on 26/03/2024.
//

import Foundation

class HomeViewModel {
    var recipesArray: [RecipeModel?] = []

    // MARK: - Closure Collection
    var showErrorMessage: ((String) -> Void)?
    var getRecipesSuccess: (() -> Void)?
    private let middlewareRecipesData = NetworkMiddleware<HomeRequest>()
    
    func getRecipes() {
        // Check network connection
        
        if !NetworkService.shared.hasInternetConnection() {
            BannerManager.showBanner(Constant.Messages.noNetworkConnection, .danger)
            return
        }
        middlewareRecipesData.call({ (request) in
            request.fetchRecipeData { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    self.recipesArray = response
                    getRecipesSuccess?()
                case .error(let error):
                    self.showErrorMessage?(error.message ?? "")
                }
            }
        })
    }
}
