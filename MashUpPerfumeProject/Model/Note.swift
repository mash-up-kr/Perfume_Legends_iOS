//
//  Note.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/12.
//

import Foundation

struct Note: Decodable, Equatable {
    let id: Int
    let name: String
    let description: String
    let thumbnailImageUrl: String
}
