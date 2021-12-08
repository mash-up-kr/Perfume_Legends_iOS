//
//  APIService.swift
//  MashUpPerfumeProject
//
//  Created by 선민승 on 2021/10/02.
//

import Foundation
import Moya
import RxSwift
import ReactorKit

struct APIService {
    
    static let shared = APIService()
    // 싱글톤객체로 생성
    let provider = MoyaProvider<APITarget>()
    // MoyaProvider(->요청 보내는 클래스) 인스턴스 생성

    func initializeInfo(model: Initialize) -> Single<Response> {
        provider.rx.request(.initialize(initialize: model))
    }

    func getMe() -> Single<Response> {
        provider.rx.request(.getMe)
    }

    func updateNickName(nicknameInfo: NickName) -> Single<Response> {
        provider.rx.request(.updateNickName(nickName: nicknameInfo))
    }

    func getNoteGroups() -> Single<Response> {
        provider.rx.request(.getNoteGroups)
    }

    func login(logInInfo: Login) -> Single<Response> {
        provider.rx.request(.login(login: logInInfo))
    }
}

extension APIService {
    func requestNoteGroups(id: Int) -> Single<Response> {
        provider.rx.request(.requestNoteGroups(id: id))
    }
    
    func requestSearch(query: String, filter: SearchFilter = .all, page: Int) -> Single<Response> {
        provider.rx.request(.requestSearch(query: query, filter: filter, page: page))
    }
    
    func requestPerfume(id: Int) -> Single<Response> {
        provider.rx.request(.requestPerfume(id: id))
    }
    
    func requestNotePerfumes(id: Int) -> Single<Response> {
        provider.rx.request(.requestNotePerfumes(id: id))
    }

    func getPerfumes(brandId: Int? = nil, noteId: Int? = nil, page: Int? = nil) -> Single<Response> {
        provider.rx.request(.getPerfumes(brandId: brandId, noteId: noteId, page: page))
    }
    
}

