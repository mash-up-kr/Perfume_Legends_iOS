//
//  Member.swift
//  MashUpPerfumeProject
//
//  Created by 최원석 on 2021/11/12.
//

import Foundation

struct Member: Codable {
    let accessToken: String
    let member: MemberInfo
}

struct MemberInfo: Codable {
    let id: Int
    let status: String
    let name: String
    let gender: String
    let ageGroup: String
}

//"accessToken": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhY20tYXBpLWRldmVsb3AiLCJtZW1iZXJJZCI6MjcwNTA4fQ.May1_C-z7VFt1nuZeBGDLQJAT3mXazA3Dwlm7CKBBOc",
//        "member": {
//            "id": 270508,
//            "status": "ASSOCIATE",
//            "name": "",
//            "gender": "UNKNOWN",
//            "ageGroup": "UNKNOWN"
//        }
