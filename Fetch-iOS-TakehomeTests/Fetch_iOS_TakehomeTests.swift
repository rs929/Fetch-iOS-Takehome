//
//  Fetch_iOS_TakehomeTests.swift
//  Fetch-iOS-TakehomeTests
//
//  Created by Richie Sun on 10/5/24.
//

import XCTest
import Kingfisher
@testable import Fetch_iOS_Takehome
import SwiftUI

final class Fetch_iOS_TakehomeTests: XCTestCase {

    private let testImageURL = URL(string: "https://www.ruizhesun.me/static/media/profile1.658402381016742cbcd0.jpg")!

    var testRecipes: [Recipe] = []

    var viewModel: RecipeGalleryViewModel!

    override func setUp() {
        super.setUp()
        viewModel = RecipeGalleryViewModel()
        testRecipes = [
            Recipe(cuisine: "Italian", name: "Spaghetti",
                   photoUrlLarge: testImageURL,
                   photoUrlSmall:testImageURL,
                   sourceUrl: nil,
                   uuid: UUID(),
                   youtubeUrl: nil),
            Recipe(cuisine: "Mexican", name: "Tacos",
                   photoUrlLarge: testImageURL,
                   photoUrlSmall: testImageURL,
                   sourceUrl: nil,
                   uuid: UUID(),
                   youtubeUrl: nil),
            Recipe(cuisine: "Japanese", name: "Sushi",
                   photoUrlLarge: testImageURL,
                   photoUrlSmall: testImageURL,
                   sourceUrl: nil,
                   uuid: UUID(),
                   youtubeUrl: nil)
        ]
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testFetchRecipes() {
        let expectation = XCTestExpectation(description: "Fetch recipes")

        NetworkManager.shared = MockNetworkManager(recipes: testRecipes)

        viewModel.fetchRecipes()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.recipeData.count, 3)
            XCTAssertEqual(self.viewModel.allRecipes.count, 3)
            XCTAssertFalse(Constants.filters.isEmpty)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFilterByCuisine() {
        viewModel.recipeData = testRecipes

        viewModel.selectedFilter = "Italian"

        let filtered = viewModel.filteredRecipes
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first?.name, "Spaghetti")
    }

    func testSearchByName() {
        viewModel.recipeData = testRecipes

        viewModel.searchText = "Tacos"

        let searched = viewModel.searchedRecipes
        XCTAssertEqual(searched.count, 1)
        XCTAssertEqual(searched.first?.name, "Tacos")
    }

    func testSearchByCuisine() {
        viewModel.recipeData = testRecipes

        viewModel.searchText = "Japanese"

        let searched = viewModel.searchedRecipes
        XCTAssertEqual(searched.count, 1)
        XCTAssertEqual(searched.first?.cuisine, "Japanese")
    }

    func testFilterAndSearchCombination() {
        viewModel.recipeData = testRecipes
        viewModel.selectedFilter = "Mexican"
        viewModel.searchText = "Tacos"

        let results = viewModel.filteredRecipes.filter { recipe in
            recipe.name.lowercased().contains(viewModel.searchText.lowercased()) ||
            recipe.cuisine.lowercased().contains(viewModel.searchText.lowercased())
        }

        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.first?.name, "Tacos")
    }

    func testRecipeDataEmptyForMalformedData() throws {
        let viewModel = RecipeGalleryViewModel()
        viewModel.endpoint = "recipes-malformed.json"

        let view = RecipeGalleryView()
            .environmentObject(viewModel)

        let hostingController = UIHostingController(rootView: view)
        hostingController.loadViewIfNeeded()

        XCTAssertEqual(viewModel.allRecipes.count, 0)
    }
}

/// Mock NetworkManager
class MockNetworkManager: NetworkManager {
    var recipes: [Recipe]

    init(recipes: [Recipe]) {
        self.recipes = recipes
        super.init()
    }

    override func fetchRecipes(endpoint: String, completion: @escaping ([Recipe]) -> Void) {
        completion(recipes)
    }
}
