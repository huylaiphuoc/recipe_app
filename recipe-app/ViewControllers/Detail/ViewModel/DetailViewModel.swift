//
//  DetailViewModel.swift
//  recipe-app
//
//  Created by Huy Lai on 26/03/2024.
//

import Foundation

class DetailViewModel {
    var recipeModel: RecipeModel? = nil
    
    func updateRecipeModel(_ recipeModel: RecipeModel) {
        self.recipeModel = recipeModel
    }
}
