//
//  LocalHighlights.swift
//  helbiz-ios-test
//
//  Created by Dusan on 20.4.22..
//

import Foundation

// MARK: - LocalHighlights
struct LocalHighlights: Codable {
    let results: [PoiResult]
    let more: Bool
    let isDeprecated: String

    enum CodingKeys: String, CodingKey {
        case results, more
        case isDeprecated = "is_deprecated"
    }
}

// MARK: - Result
struct PoiResult: Codable {
    let poiDivision: [PoiDivision]
    let pois: [Poi]

    enum CodingKeys: String, CodingKey {
        case poiDivision = "poi_division"
        case pois
    }
}

// MARK: - PoiDivision
struct PoiDivision: Codable {
    let tagName: String
    let poiIDS: [String]
    let tagLabel: String

    enum CodingKeys: String, CodingKey {
        case tagName = "tag_name"
        case poiIDS = "poi_ids"
        case tagLabel = "tag_label"
    }
}
