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

    func initializeInfo(initializeInfo: Initialize ,completion: @escaping (Result<MemberInfo, Error>) -> Void) {
        provider.request(.initialize(initialize: initializeInfo)) { result in
            self.parseRootData(result: result, completion: completion)
        }
    }

//    func initializeInfo(_ model: Initialize) -> Single<Response> {
//        provider.rx.request(.initialize(initialize: model))
//    }

    func login(logInInfo: Login ,completion: @escaping (Result<Member, Error>) -> Void) {
        provider.request(.login(login: logInInfo)) { result in
            self.parseRootData(result: result, completion: completion)
        }
    }
    
//    func login(_ model: Login) -> Single<Response> {
//        provider.rx.request(.login(login: model))
//    }

    func getMe(meInfo: Me ,completion: @escaping (Result<Member, Error>) -> Void) {
        provider.request(.getMe) { result in
            self.parseRootData(result: result, completion: completion)
        }
    }

//    func getMe(_ model: Me) -> Single<Response> {
//        provider.rx.request(.getMe)
//    }

    func updateNickName(nicknameInfo: NickName, completion: @escaping (Result<NickName, Error>) -> Void) {
        provider.request(.updateNickName(nickName: nicknameInfo)) { result in
            self.parseRootData(result: result, completion: completion)
        }
    }
}

extension APIService {
    func parseRootData<T: Decodable>(result: Result<Response, MoyaError>,
                           completion: (Result<T, Error>) -> Void) {
        switch result {
        case let .success(success):
            let responseData = success.data
            do {
                let rootData = try JSONDecoder().decode(RootResponse<T>.self, from: responseData)
                completion(.success(rootData.data))
            } catch {
                completion(.failure(error))
            }

        case let .failure(error):
            completion(.failure(error))
        }
    }
}
