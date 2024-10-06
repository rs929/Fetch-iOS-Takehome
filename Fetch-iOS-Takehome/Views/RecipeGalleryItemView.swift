//
//  RecipeGalleryItemView.swift
//  Fetch-iOS-Takehome
//
//  Created by Richie Sun on 10/5/24.
//

import SwiftUI

struct RecipeGalleryItemView: View {

    // MARK: - Properties

    let recipe: Recipe

    // MARK: - UI

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                AsyncImageView(smallPhotoUrl: recipe.photoUrlSmall, largePhotoUrl: recipe.photoUrlLarge)
                recipeInfoView
            }
            Text(recipe.cuisine)
                .background(Constants.fetchOrange)
                .padding(.top, 12)
        }
    }

    private var recipeInfoView: some View {
        VStack(alignment: .leading) {
            Text(recipe.name)
                .font(.system(size: 16, weight: .bold))
        }
    }
}
