//
//  RecipeTableViewCell.swift
//  recipe-app
//
//  Created by Huy Lai on 26/03/2024.
//

import UIKit
import SDWebImage

class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    
    func populateData(_ recipeModel: RecipeModel) {
        // Each item view in the list must show the following: - Recipe Name - Recipe Headline (as subtitle)
        // The following are optional items to display within the list - Recipe Thumbnail - Recipe Calories - Recipe difficulty
        
        nameLabel.text = recipeModel.name ?? ""
        headlineLabel.text = recipeModel.headline ?? ""
        thumbImageView.sd_setImage(with: URL(string: recipeModel.thumb ?? ""),
                                      placeholderImage: UIImage())
        caloriesLabel.text = recipeModel.calories ?? ""
        difficultyLabel.text = "\(recipeModel.difficulty ?? 0)"
    }
}
