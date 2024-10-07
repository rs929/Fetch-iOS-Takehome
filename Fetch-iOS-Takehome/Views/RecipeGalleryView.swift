//
//  ContentView.swift
//  Fetch-iOS-Takehome
//
//  Created by Richie Sun on 10/5/24.
//

import SwiftUI

struct RecipeGalleryView: View {

    // MARK: - Properties

    @StateObject private var viewModel = RecipeGalleryViewModel()

    // MARK: - UI

    var body: some View {
        GeometryReader { geometry in
            let itemWidth = (geometry.size.width - 58) / 2

            VStack {
                headerView
                    .overlay {
                        if viewModel.isSearching {
                            searchBar
                        }
                    }

                if !viewModel.isSearching {
                    filtersView
                        .padding(.bottom, 24)
                }

                ScrollView(.vertical) {
                    LazyVGrid(columns: viewModel.columns, spacing: 10) {
                        ForEach(viewModel.isSearching ? viewModel.searchedRecipes : viewModel.filteredRecipes, id: \.self) { recipe in
                            RecipeGalleryItemView(recipe: recipe)
                                .frame(width: itemWidth)
                                .onTapGesture {
                                    viewModel.selectedRecipe = recipe
                                    viewModel.isPresentingModal = true
                                }
                        }
                    }
                    .padding(.horizontal, 24)
                }
            }
        }
        .overlay {
            if viewModel.isSearching && viewModel.searchedRecipes.isEmpty {
                emptyStateView(message: "Hmm, it looks like we don’t have any recipes for that. Maybe search for something different.")
            } else if viewModel.filteredRecipes.isEmpty {
                emptyStateView(message: "Uh-oh! It seems we don't have any recipes available right now.")
            }
        }
        .onAppear {
            viewModel.fetchRecipes()
        }
        .sheet(isPresented: $viewModel.isPresentingModal) {
            recipeLinksView()
        }
    }

    private var headerView: some View {
        HStack(alignment: .center) {
            Text("RecipeApp")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Constants.gradient)

            Spacer()

            Button(action: {
                withAnimation {
                    viewModel.isSearching.toggle()
                }
            }, label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .tint(.black)
            })
        }
        .padding(.horizontal, 24)
    }

    private var searchBar: some View {
        HStack(alignment: .center) {
            TextField("Search...", text: $viewModel.searchText)
                .padding(8)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(8)
                .animation(.easeInOut, value: viewModel.isSearching)
                .onSubmit {
                    print("Searching for: \(viewModel.searchText)")
                }

            Button("Cancel") {
                withAnimation {
                    viewModel.isSearching = false
                    viewModel.searchText = ""
                }
            }
            .tint(Constants.gradient)
        }
        .padding(24)
        .background(Color.white)
    }

    private var filtersView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Constants.filters.indices, id: \.self) { index in
                    Button(action: {
                        if viewModel.selectedFilter == Constants.filters[index] {
                            viewModel.selectedFilter = ""
                        } else {
                            viewModel.selectedFilter = Constants.filters[index]
                        }
                    }, label: {
                        Text(Constants.filters[index])
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(12)
                            .background(viewModel.selectedFilter == Constants.filters[index] ? Constants.blackGradient : Constants.gradient)
                            .clipShape(.capsule)
                    })
                }
            }
            .padding(.horizontal, 24)
        }
    }

    @ViewBuilder
    private func emptyStateView(message: String) -> some View {
        VStack {
            Text("No Recipes Found")
                .font(.system(size: 24, weight: .bold))
            Text(message)
                .font(.system(size: 16, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.top, 12)
        }
        .padding(.horizontal, 24)
    }

    @ViewBuilder
    private func recipeLinksView() -> some View {
        VStack {
            if let sourceURL = viewModel.selectedRecipe?.sourceUrl {
                Button(action: {
                    viewModel.openURL(url: sourceURL)
                }) {
                    Text("Open Source Link")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding()
                        .background(Constants.gradient)
                        .clipShape(.capsule)
                }
            }

            if let youtubeURL = viewModel.selectedRecipe?.youtubeUrl {
                Button(action: {
                    viewModel.openURL(url: youtubeURL)
                }) {
                    Text("Watch on YouTube")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding()
                        .background(Constants.gradient)
                        .clipShape(.capsule)
                }
            }

            if viewModel.selectedRecipe?.sourceUrl == nil && viewModel.selectedRecipe?.youtubeUrl == nil {
                Text("No available links for this recipe.")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
            }
        }
        .presentationDetents([.height(200)])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    RecipeGalleryView()
}
