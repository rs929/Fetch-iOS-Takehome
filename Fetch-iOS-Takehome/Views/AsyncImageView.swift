//
//  AsyncImageView.swift
//  Fetch-iOS-Takehome
//
//  Created by Richie Sun on 10/6/24.
//

import SwiftUI

/// A reusable 2-stage Image view that loads in a small, followed by a larger version of the image
struct AsyncImageView: View {

    // MARK: - Properties

    @State private var largeImage: UIImage? = nil

    let smallPhotoUrl: URL
    let largePhotoUrl: URL

    // MARK: - UI

    var body: some View {
        if let largeImage {
            Image(uiImage: largeImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .transition(.opacity)
                .animation(.easeInOut, value: largeImage)
        } else {
            AsyncImage(url: smallPhotoUrl) { phase in
                switch phase {
                case .empty:
                    Constants.placeholderImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .onAppear {
                            loadLargerImage()
                        }
                case .failure:
                    Constants.errorImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                @unknown default:
                    Color.gray
                }
            }
        }
    }

    // MARK: - Helper Functions

    /// After the image is loaded from smallPhotoUrl, try to load the larger image from largePhotoUrl
    private func loadLargerImage() {
        Task {
            if let data = try? await URLSession.shared.data(from: largePhotoUrl).0,
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.largeImage = image
                }
            }
        }
    }

}
