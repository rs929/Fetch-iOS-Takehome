//
//  RecipeGalleryViewModel.swift
//  Fetch-iOS-Takehome
//
//  Created by Richie Sun on 10/5/24.
//

import SwiftUI

class RecipeGalleryViewModel: ObservableObject {

    // MARK: - Properties

    @Published var recipeData: [Recipe] = []
    @Published var isSearching = false
    @Published var searchText = ""
    @Published var selectedFilter = ""

    @Published var selectedRecipe: Recipe?
    @Published var isPresentingModal = false

    var allRecipes: [Recipe] = []

    var filteredRecipes: [Recipe] {
        if selectedFilter.isEmpty {
            return recipeData
        } else {
            return recipeData.filter {
                $0.cuisine.lowercased() == selectedFilter.lowercased()
            }
        }
    }

    var searchedRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipeData
        } else {
            return recipeData.filter {
                $0.name.lowercased().contains(searchText.lowercased()) || $0.cuisine.lowercased().contains(searchText.lowercased())
            }
        }
    }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var endpoint = "recipes.json"

    // MARK: - Helper Functions

    /// Fetches all recipes
    func fetchRecipes() {
        NetworkManager.shared.fetchRecipes(endpoint: endpoint) { [weak self] recipes in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.recipeData = recipes
                self.allRecipes = recipes
                self.extractFilters()
            }
        }
    }

    func openURL(url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

    /// Extracts all cuisine types from the data to update filter categories
    private func extractFilters() {
        let allCuisines = allRecipes.compactMap { $0.cuisine }
        Constants.filters = Array(Set(allCuisines))
    }

}
