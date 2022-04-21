//
//  Poi.swift
//  helbiz-ios-test
//
//  Created by Dusan on 20.4.22..
//

import Foundation

struct Poi: Codable {
    let coordinates: Coordinates
    let name: String
    let distance: Int
    let images: [Image]
    let locationID, id, intro: String
    let score: Double
    let snippet: String

    enum CodingKeys: String, CodingKey {
        case coordinates, name, distance, images
        case locationID = "location_id"
        case id, intro, score, snippet
    }
}
