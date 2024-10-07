//
//  CachedImageView.swift
//  Fetch-iOS-Takehome
//
//  Created by Richie Sun on 10/6/24.
//

import Kingfisher
import SwiftUI

struct CachedImageView: View {

    // MARK: - Properties

    @State private var loadedLargeImage = false
    @State private var imageLoadingFailed = false

    let smallPhotoUrl: URL
    let largePhotoUrl: URL

    // MARK: - UI

    var body: some View {
        ZStack {
            KFImage(smallPhotoUrl)
                .placeholder {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
                .onSuccess { result in
                    loadedLargeImage = true
                }
                .onFailure { error in
                    imageLoadingFailed = true
                    print("Error loading small image: \(error)")
                }
                .cacheOriginalImage()
                .resizable()
                .aspectRatio(contentMode: .fit)

            if loadedLargeImage {
                KFImage(largePhotoUrl)
                    .cacheOriginalImage()
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .transition(.opacity)
                    .animation(.easeInOut, value: loadedLargeImage)
            }

            if imageLoadingFailed {
                Image("errorImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}
