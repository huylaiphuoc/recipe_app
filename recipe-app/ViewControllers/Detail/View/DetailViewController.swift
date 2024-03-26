//
//  DetailViewController.swift
//  recipe-app
//
//  Created by Huy Lai on 26/03/2024.
//

import UIKit
import SDWebImage

class DetailViewController: BaseViewController {
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var proteinsLabel: UILabel!
    
    private let viewModel = DetailViewModel()
    
    init(recipeModel: RecipeModel) {
        viewModel.updateRecipeModel(recipeModel)
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        populateData()
    }
    
    private func setupViews() {
        mainScrollView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 10, right: 0)
    }
    
    private func populateData() {
        // This should show the following: - Recipe Name - Recipe Headline (as subtitle) - Recipe description - Recipe calories - Recipe proteins - Recipe Image (Optional)
        
        if let model = viewModel.recipeModel {
            nameLabel.text = model.name ?? ""
            headlineLabel.text = model.headline ?? ""
            descriptionLabel.attributedText = (model.description ?? "").convertHtmlToNSAttributedString
            descriptionLabel.lineHeight = 30
            caloriesLabel.text = model.calories ?? ""
            proteinsLabel.text = model.proteins ?? ""
            recipeImageView.sd_setImage(with: URL(string: model.image ?? ""),
                                          placeholderImage: UIImage())
        }
    }
}
