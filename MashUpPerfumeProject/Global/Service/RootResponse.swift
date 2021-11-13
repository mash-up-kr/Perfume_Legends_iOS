//
//  RootResponse.swift
//  MashUpPerfumeProject
//
//  Created by 최원석 on 2021/11/12.
//

import Foundation

struct RootResponse<T: Decodable>: Decodable {
    var data: T
}
