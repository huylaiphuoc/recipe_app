//
//  RecipeModel.swift
//  recipe-app
//
//  Created by Huy Lai on 26/03/2024.
//

import Foundation

struct RecipeModel: Codable {
    let name: String?
    let headline: String?
    let image: String?
    let thumb: String?
    let description: String?
    let proteins: String?
    let calories: String?
    let difficulty: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case headline
        case image
        case thumb
        case description
        case proteins
        case calories
        case difficulty
    }
}
