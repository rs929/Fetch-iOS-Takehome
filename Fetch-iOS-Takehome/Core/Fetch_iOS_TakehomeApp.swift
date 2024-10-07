//
//  Fetch_iOS_TakehomeApp.swift
//  Fetch-iOS-Takehome
//
//  Created by Richie Sun on 10/5/24.
//

import Kingfisher
import SwiftUI

@main
struct Fetch_iOS_TakehomeApp: App {
    var body: some Scene {
        WindowGroup {
            RecipeGalleryView()
                .onAppear {
                    setupCache()
                }
        }
    }

    /// Sets up Kingfisher image cache 2^20 indicates around 1MB of storage
    private func setupCache() {
        let cache = ImageCache.default
        cache.memoryStorage.config.totalCostLimit = 2^20 * 100
        cache.diskStorage.config.sizeLimit = 2^20 * 500
    }
}
