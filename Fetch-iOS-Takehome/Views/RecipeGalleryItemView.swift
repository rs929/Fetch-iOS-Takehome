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
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading) {
                CachedImageView(smallPhotoUrl: recipe.photoUrlSmall, largePhotoUrl: recipe.photoUrlLarge)
                recipeInfoView
            }
            .background(.white)
            .clipShape(.rect(cornerRadius: 10))
            .shadow(radius: 2)

            Text(recipe.cuisine)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.white)
                .padding(5)
                .background(Constants.fetchOrange)
                .padding(.top, 12)
        }

    }

    private var recipeInfoView: some View {
        VStack(alignment: .leading) {
            Text(recipe.name)
                .font(.system(size: 16, weight: .bold))
                .padding(5)
        }

    }
}
