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
    
    var baseURL: URL {
        // baseURL - 서버의 도메인
        return URL(string: "")!
    }
    
    // 세부 경로
    var path: String {
        switch self {
        // 1. User - Authorization
        case .login:
            return "/user/login"
        }
    }
    var method: Moya.Method {
        // method - 통신 method (get, post, put, delete ...)
        switch self {
        case .login:
            return .post
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
        switch self {
        case .login:
            return ["Content-Type":"application/json"]
        }
    }
}
