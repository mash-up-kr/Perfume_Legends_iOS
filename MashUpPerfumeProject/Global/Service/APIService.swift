//
//  APIService.swift
//  MashUpPerfumeProject
//
//  Created by 선민승 on 2021/10/02.
//

import Foundation
import Moya
import RxSwift

struct APIService {
    
    static let shared = APIService()
    // 싱글톤객체로 생성
    let provider = MoyaProvider<APITarget>()
    // MoyaProvider(->요청 보내는 클래스) 인스턴스 생성
    
    func login(_ access: String) -> Single<Response> {
        provider.rx.request(.login(access: access))
    }
}

extension APIService {
    func requestNoteGroups(id: Int) -> Single<Response> {
        provider.rx.request(.requestNoteGroups(id: id))
    }
}
