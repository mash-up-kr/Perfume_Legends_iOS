//
//  OnboardingSecondReactor.swift
//  MashUpPerfumeProject
//
//  Created by 최원석 on 2021/10/19.
//

import Foundation
import RxSwift
import ReactorKit

final class OnboardingSecondReactor: Reactor {

    enum Action { // 정의만 한다
        case setNickname(String)
    }

    enum Mutation {
        case setNickname(String?, Bool?)
        case setIsLoading(Bool)
    }

    struct State {
        var nickname: String?
        var isValideNickname: Bool?
        var isLoading = false
    }

    let initialState = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .setNickname(nickname):

            let newNickname = makeNewNickname(nickname: nickname)

            if newNickname.count > 1 {

                return  Observable.concat([
                    .just(.setIsLoading(true)),

                    APIService.shared.updateNickName(nicknameInfo: NickName(nickname: newNickname))
                        .asObservable()
                        .map { _ in
                            Mutation.setNickname(newNickname, true)
                        }
                        .catchAndReturn(.setNickname(newNickname, false)),

                    .just(.setIsLoading(false))
                ])
            } else {
                return .just(.setNickname(nickname, true))
            }
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case let .setNickname(nickname, isValidNickname):
            newState.nickname = nickname
            newState.isValideNickname = isValidNickname
            print(nickname, isValidNickname)

        case let .setIsLoading(isLoading):
            newState.isLoading = isLoading
        }

        return newState
    }
}

extension OnboardingSecondReactor {
    func makeNewNickname(nickname: String) -> String {

        var newNickname = nickname.trimmingCharacters(in: .whitespaces)
        newNickname = nickname.components(separatedBy: ["~","!","@",","," ",".","/","?","<",">","#","$","%","^","&","*","(",")","-","_","+","="]).joined()

        return newNickname
    }
}
