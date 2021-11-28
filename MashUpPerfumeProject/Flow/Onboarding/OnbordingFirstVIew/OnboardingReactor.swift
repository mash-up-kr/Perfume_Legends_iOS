//
//  File.swift
//  MashUpPerfumeProject
//
//  Created by 최원석 on 2021/10/17.
//

import Foundation
import RxSwift
import ReactorKit

final class OnboardingReactor: Reactor {

    enum Action { // 정의만 한다

    }

    enum Mutation {

    }

    struct State {

    }

    let initialState = State()

    func mutate(action: Action) -> Observable<Mutation> {

    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        return newState
    }
}
