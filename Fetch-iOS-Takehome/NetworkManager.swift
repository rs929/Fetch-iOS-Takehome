//
//  NetworkManager.swift
//  Fetch-iOS-Takehome
//
//  Created by Richie Sun on 10/5/24.
//

import Foundation

class NetworkManager {

    // MARK: - Shared Instance

    static let shared = NetworkManager()

    private init() { }

    // MARK: - Host Endpoint

    private let hostURL = Keys.hostEndpoint

    // MARK: - Networking Functions

    func fetchRecipes(completion: @escaping ([Recipe]) -> Void) {

        let endpoint = "\(hostURL)/recipes.json"

        print(endpoint)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        var urlRequest = URLRequest(url: URL(string: endpoint)!)
        urlRequest.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in

            guard error == nil, let data else {
                print("Error in NetworkManager.fetchRoster: \(String(describing: error))")
                return
            }

            do {
                let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
                completion(recipeResponse.recipes)
            } catch {
                print("Decoding Error: \(error.localizedDescription)")
            }
        }

        task.resume()
    }

    // MARK: - Testing Functions


}
