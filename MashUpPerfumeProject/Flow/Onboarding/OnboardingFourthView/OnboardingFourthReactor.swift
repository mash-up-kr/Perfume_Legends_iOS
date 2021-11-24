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
        case requestNote
        case selectPerfumeType([Int]?)
        case setMemberInitialize(String?, String?, [Int]?)
    }

    enum Mutation {
        case setNoteGroups([NoteGroup])
        case setPerfumeType([Int]?)
        case setMemberInitialize(MemberInfo?)
        case setIsLoading(Bool)
    }

    struct State {
        let gender: String?
        let age: String?
        var perfumeTypes: [Int]?
        var noteGroups: [NoteGroup]?
        var isLoading = false
    }

    let initialState: State

    init(gender: String?, age: String?) {
        initialState = State(gender: gender, age: age)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .requestNote:

            return Observable.concat([
                .just(.setIsLoading(true)),

                APIService.shared.getNoteGroups()
                    .asObservable()
                    .map([NoteGroup].self, atKeyPath: "data.noteGroups", using: JSONDecoder(), failsOnEmptyData: false)
                    .map { Mutation.setNoteGroups($0) },

                .just(.setIsLoading(false))
            ])

        case let .selectPerfumeType(perfumeTypes):
            return .just(.setPerfumeType(perfumeTypes))
            
        case let .setMemberInitialize(gender, age, perfumeTypes):
            return APIService.shared.initializeInfo(model: Initialize(gender: gender, ageGroup: age, noteGroupsIds: perfumeTypes))
                .asObservable()
                .map(MemberInfo.self, atKeyPath: "data.member", using: JSONDecoder(), failsOnEmptyData: false)
                .map { Mutation.setMemberInitialize($0) }
            
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case let .setNoteGroups(noteGroups):
            newState.noteGroups = noteGroups

        case let .setPerfumeType(perfumeTypes):
            newState.perfumeTypes = perfumeTypes

        case let .setMemberInitialize(memberInfo):
            break

        case let .setIsLoading(isLoading):
            newState.isLoading = isLoading
        }

        print(newState)

        return newState
    }
}
