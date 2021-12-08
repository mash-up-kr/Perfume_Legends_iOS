//
//  NoteGroupReactor.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/01.
//

import Foundation
import RxSwift
import Moya
import ReactorKit

final class NoteGroupReactor: Reactor {
    enum Action {
        case requestNotes
    }
    
    enum Mutation {
        case setNotes(NoteGroupDetail)
        case setIsLoading(Bool)
    }
    
    struct State {
        let id: Int?
        
        var noteGroup: NoteGroupDetail?
        var isLoading = false
    }
    
    let initialState: State
    
    init(id: Int?) {
        initialState = State(id: id)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .requestNotes:
            guard let id = currentState.id else { return .empty() }
            
            return Observable.concat([
                .just(.setIsLoading(true)),
                
                requestNoteGroups(id: id)
                    .asObservable()
                    .map(NoteGroupDetail.self, atKeyPath: "data.noteGroup")
                    .map { Mutation.setNotes($0)},
            
                .just(.setIsLoading(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setNotes(noteGroup):
            newState.noteGroup = noteGroup
            
        case let .setIsLoading(isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
}

extension NoteGroupReactor {
    private func requestNoteGroups(id: Int) -> Single<Response> {
        APIService.shared.requestNoteGroups(id: id)
    }
}
