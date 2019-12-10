//
//  RecipeSearchAPI.swift
//  RecipeSearch
//
//  Created by Jaheed Haynes on 12/10/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct RecipeSearchAPI {
    static func fetchRecipe(for searchQuery: String, completion: @escaping (Result<[Recipe], AppError>)->()) {
        
        let recipeEndpointURL = "https://api.edamam.com/search?q=\(searchQuery)&app_id=\(SecretKey.appId)&app_key=(\(SecretKey.appId))&from=0&to=50"
        
        guard let url = URL(string: recipeEndpointURL) else {
            completion(.failure(.badURL(recipeEndpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case.failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode(RecipeSearch.self, from: data)
                    
                    // TODO: use searchResults to create an array of recipes
                    // TODO:
                    
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
