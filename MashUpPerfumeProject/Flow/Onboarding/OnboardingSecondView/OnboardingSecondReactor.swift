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
        case makeNickname(String?)
        case setNickname(String?)
    }

    enum Mutation {
        case makeNickname(String?)
        case setNickname(String?)
    }

    struct State {
        var nickname: String?
        // nickname return에 대한 상태값을 받아야지 텍스트필드와 label을 띄울 수 있다.
    }

    let initialState = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .makeNickname(nickname):
            return .just(.makeNickname(nickname))
        case let .setNickname(nickname):
            let model = NickName(nickname: nickname ?? "")
            var returnModel = NickName(nickname: "")
            APIService.shared.updateNickName(nicknameInfo: model) { result in
                switch result {
                case .success(let nickname):
                    returnModel = nickname
                case .failure(let error):
                    print("error가 발생했습니다.")
                }
            }
            return .just(.setNickname(nickname))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case let .makeNickname(nickname):
            newState.nickname = nickname
            print(nickname)
        case let .setNickname(nickname):
            newState.nickname = nickname
            print(nickname)
        }

        return newState
    }
}
