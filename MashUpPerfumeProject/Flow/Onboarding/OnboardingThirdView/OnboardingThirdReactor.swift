//
//  OnboardingThirdReactor.swift
//  MashUpPerfumeProject
//
//  Created by 최원석 on 2021/10/21.
//

import Foundation
import RxSwift
import ReactorKit

final class OnboardingThirdReactor: Reactor {

    enum Action { // 정의만 한다
        case selectGender(OnboardingThirdViewController.Gender?)
        case selectAge(OnboardingThirdViewController.Age?)
    }

    enum Mutation {
        case setGender(OnboardingThirdViewController.Gender?)
        case setAge(OnboardingThirdViewController.Age?)
    }

    struct State {
        var gender: OnboardingThirdViewController.Gender?
        var age: OnboardingThirdViewController.Age?
    }

    let initialState = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .selectGender(gender):
            return .just(.setGender(gender))

        case let .selectAge(age):
            return .just(.setAge(age))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case let .setGender(gender):
            newState.gender = gender
        case let .setAge(age):
            newState.age = age
        }

        print("newState \(newState.gender), \(newState.age)")

        return newState
    }
}
