//
//  SignInReactor.swift
//  MashUpPerfumeProject
//
//  Created by 최원석 on 2021/11/17.
//

import Foundation
import RxSwift
import ReactorKit

final class SignInReactor: Reactor {

    enum Action { // 정의만 한다
        case requestMemberInfo
        case postLogInInfo(String?, String?)
        case requestAccessToken(String?)
    }

    enum Mutation {
        case setMemberInfo(MemberInfo?, Bool)
        case setLogInInfo(Member)
        case setAccessTokenExistence(Bool)
        case setIsLoading(Bool)
    }

    struct State {
        var idProviderType: String?
        var idProviderUserId: String?
        var accessToken: String?
        var memberInfo: MemberInfo?
        var isSuccess: Bool?
        var accessTokenExistence: Bool?
        var isLoading = false
    }

    var initialState = State()

    init(idProviderType: String?, idProviderUserId: String?, accesstoken: String?) {
        initialState = State(idProviderType: idProviderType, idProviderUserId: idProviderUserId, accessToken: accesstoken, memberInfo: nil, isSuccess: nil, accessTokenExistence: nil)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .requestMemberInfo:

            return Observable.concat([
                .just(.setIsLoading(true)),

                APIService.shared.getMe()
                    .asObservable()
                    .map(MemberInfo.self, atKeyPath: "data.member", using: JSONDecoder(), failsOnEmptyData: false)
                    .map { Mutation.setMemberInfo($0, true) }
                    .catchAndReturn(.setMemberInfo(nil, false)),

                .just(.setIsLoading(false))
            ])
            
        case let .postLogInInfo(type, id):

            return Observable.concat([
                .just(.setIsLoading(true)),

                APIService.shared.login(logInInfo: Login(idProviderType: type, idProviderUserId: id))
                    .asObservable()
                    .map(Member.self, atKeyPath: "data", using: JSONDecoder(), failsOnEmptyData: false)
                    .map { Mutation.setLogInInfo($0) }
                    .catchAndReturn(Mutation.setLogInInfo(Member(accessToken: "", member: MemberInfo(id: 213123, status: "", name: "", gender: "", ageGroup: "")))),

                .just(.setIsLoading(false))
            ])

        case let .requestAccessToken(accessToken):
            if accessToken != nil {
                return .just(.setAccessTokenExistence(true))
            } else {
                return .just(.setAccessTokenExistence(false))
            }
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case let .setMemberInfo(memberInfo, isSuccess):
            newState.memberInfo = memberInfo
            newState.isSuccess = isSuccess

        case let .setLogInInfo(logInInfo):
            newState.accessToken = logInInfo.accessToken

        case let .setAccessTokenExistence(bool):
            newState.accessTokenExistence = bool

        case let .setIsLoading(isLoading):
            newState.isLoading = isLoading
        }
        print(newState)

        return newState
    }
}
