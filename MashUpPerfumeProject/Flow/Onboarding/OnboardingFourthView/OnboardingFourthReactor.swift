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
        case setMemberInitialize(String?, String?, [Int]?)
    }

    enum Mutation {
        case setPerfumeType([Int]?)
        case setMemberInitialize(MemberInfo?)
    }

    struct State {
        var gender: String?
        var age: String?
        var perfumeTypes: [Int]?
    }

    var initialState = State()

    init(gender: String?, age: String?) {
        initialState = State(gender: gender, age: age)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .selectPerfumeType(perfumeTypes):
            return .just(.setPerfumeType(perfumeTypes))
        case let .setMemberInitialize(gender, age, noteGroupIds):
            let model = Initialize(gender: gender, ageGroup: age, noteGroupsIds: noteGroupIds)
            var returnModel = MemberInfo(id: 0, status: "", name: "", gender: "", ageGroup: "")
            APIService.shared.initializeInfo(initializeInfo: model) { result in
                switch result {
                case .success(let memberInfo):
                    returnModel = memberInfo
                case .failure(let error):
                    print("error가 발생했습니다.")
                }
            }
            return .just(.setMemberInitialize(returnModel))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case let .setPerfumeType(perfumeTypes):
            newState.perfumeTypes = perfumeTypes
        case let .setMemberInitialize(memberInfo):
            newState.gender = memberInfo?.gender
            newState.age = memberInfo?.ageGroup
        }

        print(newState)

        return newState
    }
}
