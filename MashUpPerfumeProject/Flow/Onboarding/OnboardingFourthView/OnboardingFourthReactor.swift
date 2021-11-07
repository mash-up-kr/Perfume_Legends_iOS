//
//  OnboardingFourthReactor.swift
//  MashUpPerfumeProject
//
//  Created by 최원석 on 2021/10/24.
//

import Foundation
import RxSwift
import ReactorKit

final class OnboardingFourthReactor: Reactor {

    enum Action { // 정의만 한다
        case selectPerfumeType([Int]?)
    }

    enum Mutation {
        case setPerfumeType([Int]?)
    }

    struct State {
        var perfumeTypes: [Int]?
    }

    let initialState = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .selectPerfumeType(perfumeTypes):
            return .just(.setPerfumeType(perfumeTypes))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case let .setPerfumeType(perfumeTypes):
            newState.perfumeTypes = perfumeTypes
        }

        return newState
    }
}
