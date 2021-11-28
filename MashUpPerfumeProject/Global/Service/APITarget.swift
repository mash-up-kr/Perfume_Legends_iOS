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
    case requestNoteGroups(id: Int)
    case requestSearch(query: String, filter: SearchFilter)
    case requestPerfume(id: Int)
    case requestNotePerfumes(id: Int)
    case initialize(initialize: Initialize)
    case login(login: Login) // 로그인
    case getMe
    case updateNickName(nickName: NickName)
    case getNoteGroups


    var baseURL: URL {
        // baseURL - 서버의 도메인
        return URL(string: "http://3.35.167.190/api/v1")!
    }
    
    // 세부 경로
    var path: String {
        switch self {
        case let .requestNoteGroups(id):
            return "/note-groups/\(id)"
            
        case .requestSearch:
            return "/search"
            
        case let .requestPerfume(id):
            return "/perfumes/\(id)"
            
        case let .requestNotePerfumes(id):
            return "/notes/\(id)"
        case .initialize:
            return "/members/initialize"
            
        case .login:
            return "/members/login"
            
        case .getMe:
            return "/members/me"
            
        case .updateNickName:
            return "/members/me/nickname"
            
        case .getNoteGroups:
            return "/note-groups"
        }
    }

    var method: Moya.Method {
        // method - 통신 method (get, post, put, delete ...)
        switch self {
        case .requestNoteGroups:
            return .get
            
        case .requestSearch:
            return .post
            
        case .requestPerfume:
            return .get
            
        case .requestNotePerfumes:
            return .get
            
        case .initialize:
            return .post
            
        case .login:
            return .post
            
        case .getMe:
            return .get
            
        case .updateNickName:
            return .put
            
        case .getNoteGroups:
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
        case .requestNoteGroups:
            return .requestPlain
            
        case let .requestSearch(query, filter):
            return .requestParameters(parameters:
                                        ["name": query,
                                         "filter": filter.rawValue],
                                      encoding: JSONEncoding.default)
            
        case .requestPerfume:
            return .requestPlain
            
        case .requestNotePerfumes:
            return .requestPlain
            
        case .initialize(let initialize):
            return .requestJSONEncodable(initialize)
            
        case .login(let login):
            return .requestJSONEncodable(login)
            
        case .getMe:
            return .requestPlain
//        case .updateNickName(let nickname):
//            return .requestParameters(parameters: ["nickname": nickname], encoding: JSONEncoding.default)
        case .updateNickName(let nickName):
            return .requestJSONEncodable(nickName)
            
        case .getNoteGroups:
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

        if let accesstoken = UserDefaults.standard.string(forKey: "accesstoken") {
            return ["Authorization": "Bearer \(accesstoken)"]
        } else {
            return ["Authorization": ""]
        }
    }
}
