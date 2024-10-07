//
//  Keys.swift
//  Fetch-iOS-Takehome
//
//  Created by Richie Sun on 10/6/24.
//

import Foundation

/// Class to store private keys and endpoints to avoid exposing our backend endpoints
struct Keys {

    static let hostEndpoint = Keys.keyDict["HOST"] as? String ?? ""

    private static let keyDict: NSDictionary = {
        guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) else { return [:] }
        return dict
    }()
}
