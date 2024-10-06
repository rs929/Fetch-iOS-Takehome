//
//  ContentView.swift
//  Fetch-iOS-Takehome
//
//  Created by Richie Sun on 10/5/24.
//

import SwiftUI

struct RecipeGalleryView: View {

    // MARK: - Properties

    @State private var recipeData: [Recipe] = []

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    // MARK: - UI

    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns) {
                ForEach(recipeData, id: \.self) { recipe in
                    RecipeGalleryItemView(recipe: recipe)
                }
            }
        }
        .background(Constants.fetchOrange)
        .onAppear {
            NetworkManager.shared.fetchRecipes { recipes in
                recipeData = recipes
            }
        }
    }

    private var headerView: some View {
        HStack {

        }
    }

    private var filtersView: some View {
        HStack {

        }
    }
}

#Preview {
    RecipeGalleryView()
}
