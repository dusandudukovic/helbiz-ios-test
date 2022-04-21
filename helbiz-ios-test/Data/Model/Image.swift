//
//  Image.swift
//  helbiz-ios-test
//
//  Created by Dusan on 20.4.22..
//

import Foundation

// MARK: - Image
struct Image: Codable {
    let attribution: Attribution
    let sourceURL: String
    let caption: String
    let sizes: Sizes
    let sourceID: String

    enum CodingKeys: String, CodingKey {
        case attribution
        case sourceURL = "source_url"
        case caption, sizes
        case sourceID = "source_id"
    }
}

// MARK: - Attribution
struct Attribution: Codable {
    let licenseText: String
    let licenseLink: String
    let attributionText: String
    let attributionLink: String
    let format: String

    enum CodingKeys: String, CodingKey {
        case licenseText = "license_text"
        case licenseLink = "license_link"
        case attributionText = "attribution_text"
        case attributionLink = "attribution_link"
        case format
    }
}

// MARK: - Sizes
struct Sizes: Codable {
    let original, medium, thumbnail: Medium
}

// MARK: - Medium
struct Medium: Codable {
    let url: String
    let height, bytes, width: Int
    let format: String
}
