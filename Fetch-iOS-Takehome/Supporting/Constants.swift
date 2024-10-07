//
//  Image + Extensions.swift
//  Fetch-iOS-Takehome
//
//  Created by Richie Sun on 10/6/24.
//

import SwiftUI

struct Constants {

    // Colors
    static let fetchOrange = Color(red: 251/255, green: 171/255, blue: 27/255)
    static let pink = Color(red: 255/255, green: 16/255, blue: 231/255)

    static let gradient = LinearGradient(stops: [
        .init(color: fetchOrange, location: 0.0),
        .init(color: pink, location: 1.0)
    ], startPoint: .leading, endPoint: .trailing)

    static let blackGradient = LinearGradient(stops: [
        .init(color: .black, location: 0.0),
        .init(color: .black, location: 1.0)
    ], startPoint: .leading, endPoint: .trailing)

    // Default images
    static let placeholderImage = Image("placeholderImage")
    static let errorImage = Image("errorImage")

    // Cuisine Type Filters (Updated based on fetchRecipe call)
    static var filters = ["American", "British", "Canadian", "Malaysian", "French"]
}
