//
//  NoteCollectionReactor.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/01.
//

import Foundation
import RxSwift
import Moya
import ReactorKit

final class NoteCollectionReactor: Reactor {
    enum Action {
        case requestNotePerfumes
    }
    
    enum Mutation {
        case setPerfumes([SearchResult.Item])
        case setIsLoading(Bool)
    }
    
    struct State {
        let id: Int
        
        var perfumes: [SearchResult.Item]?
        var isLoading = false
    }
    
    let initialState: State
    
    init(id: Int) {
        initialState = State(id: id)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .requestNotePerfumes:
            return Observable.concat([
                .just(.setIsLoading(true)),
                
                requestNotePerfumes(id: currentState.id)
                    .asObservable()
                    .map([SearchResult.Item].self, atKeyPath: "data.note.perfumes")
                    .map { Mutation.setPerfumes($0) }
                    .catch {
                        log($0)
                        return .just(.setIsLoading(false))
                    },
            
                .just(.setIsLoading(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setPerfumes(perfumes):
            newState.perfumes = perfumes
            
        case let .setIsLoading(isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
}

extension NoteCollectionReactor {
    private func requestNotePerfumes(id: Int) -> Single<Response>{
        APIService.shared.requestNotePerfumes(id: id)
    }
}
