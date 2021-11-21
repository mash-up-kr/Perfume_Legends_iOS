//
//  PerfumeDetail.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/22.
//

import Foundation

struct PerfumeDetail: Decodable, Equatable {
    let accords: [Accord]
    let name: String
    let brandName: String
    let description: String
    let gender: String
    let id: Int
    let imageUrl: String
    let thumbnailImageUrl: String
    let notes: Notes
    let similarPerfumes: [SearchResult.Item]
    
    struct Accord: Decodable, Equatable {
        let backgroundColor: String
        let name: String
        let opacity: Double
        let score: Double
        let textColor: String
    }
    
    struct Notes: Decodable, Equatable {
        let base: [String]
        let middle: [String]
        let top: [String]
        let unknown: [String]
    }
}
