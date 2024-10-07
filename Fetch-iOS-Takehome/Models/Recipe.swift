//
//  Recipe.swift
//  Fetch-iOS-Takehome
//
//  Created by Richie Sun on 10/6/24.
//

import Foundation

struct Recipe: Codable, Hashable {
    let cuisine: String
    let name: String
    let photoUrlLarge: URL
    let photoUrlSmall: URL
    let sourceUrl: URL?
    let uuid: UUID
    let youtubeUrl: URL?
}
