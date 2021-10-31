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
    }

    enum Mutation {
        case setNickname(String?)
    }

    struct State {
        var nickname: String?
    }

    let initialState = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .makeNickname(nickname):
            return .just(.setNickname(nickname))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case let .setNickname(nickname):
            newState.nickname = nickname
        }

        return newState
    }
}
