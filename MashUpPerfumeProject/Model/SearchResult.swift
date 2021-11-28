//
//  SearchResult.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/13.
//

import Foundation

struct SearchResult: Decodable, Equatable {
    let brands: [Item]
    let perfumes: [Item]
    
    var items: [Item] {
        var items = [Item]()
        brands.forEach {
            var newValue = $0
            newValue.type = .brand
            items.append(newValue)
        }
        perfumes.forEach {
            var newValue = $0
            newValue.type = .perfume
            items.append(newValue)
        }
        
        return items
    }
    
}

extension SearchResult {
    struct Item: Decodable, Equatable {
        let id: Int
        let name: String
        let thumbnailImageUrl: String
        
        var type: SearchType?
    }
}

extension SearchResult {
    enum SearchType: Decodable {
        case brand
        case perfume
    }
}

enum SearchFilter: String {
    case all = "all"
    case brand = "brand"
    case perfume = "perfume"
}
