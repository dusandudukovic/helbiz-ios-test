//
//  Tag.swift
//  helbiz-ios-test
//
//  Created by Dusan on 20.4.22..
//

import Foundation

struct TagsResponse: Codable {
   let results: [Tag]
   let more: Bool
   let isDeprecated: String

   enum CodingKeys: String, CodingKey {
       case results, more
       case isDeprecated = "is_deprecated"
   }
}

// MARK: - Result
struct Tag: Codable {
   let name, label: String
   let score: Double
   let poiCount: Int

   enum CodingKeys: String, CodingKey {
       case name, label, score
       case poiCount = "poi_count"
   }
}
