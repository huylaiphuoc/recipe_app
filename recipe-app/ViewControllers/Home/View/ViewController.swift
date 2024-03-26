//
//  ViewController.swift
//  recipe-app
//
//  Created by Huy Lai on 26/03/2024.
//

import UIKit

class ViewController: BaseViewController {
    @IBOutlet weak var recipesTableView: UITableView!
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home"
        setupViewModel()
        setupTableView()
    }
    
    private func setupTableView() {
        recipesTableView.registerNIB(with: RecipeTableViewCell.self)
    }
    
    private func setupViewModel() {
        viewModel.showErrorMessage = { errorMessage in
            if !errorMessage.isEmpty {
                BannerManager.showBanner(errorMessage, .danger)
            }
        }
        viewModel.getRecipesSuccess = { [weak self] in
            guard let self = self else { return }
            self.recipesTableView.reloadData()
        }
        viewModel.getRecipes()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedArray = viewModel.recipesArray
        let selectedRow = indexPath.row
        if !selectedArray.isEmpty, selectedArray.count > selectedRow {
            let cell = tableView.dequeueCell(with: RecipeTableViewCell.self)!
            cell.selectionStyle = .none
            cell.populateData(selectedArray[selectedRow]!)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedRecipeModel = viewModel.recipesArray[indexPath.row] {
            navigationController?.pushViewController(DetailViewController(recipeModel: selectedRecipeModel), animated: true)
        }
    }
}

