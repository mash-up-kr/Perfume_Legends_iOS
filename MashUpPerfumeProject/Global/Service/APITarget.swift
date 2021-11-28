//
//  APIService.swift
//  MashUpPerfumeProject
//
//  Created by 선민승 on 2021/10/02.
//

import Foundation
import Moya

enum APITarget: TargetType {
    // 1. User - Authorization
    case login(access: String) // 로그인
    case requestNoteGroups(id: Int)
    case requestSearch(query: String)
    case requestPerfume(id: Int)
    case requestNotePerfumes(id: Int)
    
    var baseURL: URL {
        // baseURL - 서버의 도메인
        return URL(string: "http://3.35.167.190/api/v1")!
    }
    
    // 세부 경로
    var path: String {
        switch self {
        // 1. User - Authorization
        case .login:
            return "/user/login"
            
        case let .requestNoteGroups(id):
            return "/note-groups/\(id)"
            
        case .requestSearch:
            return "/search"
            
        case let .requestPerfume(id):
            return "/perfumes/\(id)"
            
        case let .requestNotePerfumes(id):
            return "/notes/\(id)"
        }
    }
    var method: Moya.Method {
        // method - 통신 method (get, post, put, delete ...)
        switch self {
        case .login:
            return .post
            
        case .requestNoteGroups:
            return .get
            
        case .requestSearch:
            return .post
            
        case .requestPerfume:
            return .get
            
        case .requestNotePerfumes:
            return .get
        }
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return Data()
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        // task - 리퀘스트에 사용되는 파라미터 설정
        // 파라미터가 없을 때는 - .requestPlain
        // 파라미터 존재시에는 - .requestParameters(parameters: ["first_name": firstName, "last_name": lastName], encoding: JSONEncoding.default)
        switch self {
        case .login(let access):
            return .requestParameters(parameters: ["access_token": access], encoding: JSONEncoding.default)
            
        case .requestNoteGroups:
            return .requestPlain
            
        case let .requestSearch(query):
            return .requestParameters(parameters: ["name": query], encoding: JSONEncoding.default)
            
        case .requestPerfume:
            return .requestPlain
            
        case .requestNotePerfumes:
            return .requestPlain
        }
        
    }
    
    /// The type of validation to perform on the request. Default is `.none`.
    var validationType: ValidationType {
        // validationType - 허용할 response의 타입
        return .successAndRedirectCodes
    }
    
    /// The headers to be used in the request.
    var headers: [String: String]? {
        // headers - HTTP header
//        switch self {
//        case .login:
//            return ["Content-Type":"application/json"]
//        }
        return ["Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhY20tYXBpLWRldmVsb3AiLCJtZW1iZXJJZCI6MjQ1ODU5fQ.t2stUH5_C8HcpjJb_IFtwG5o4xN5AAPgozvHxIPbTbM"]
    }
}
