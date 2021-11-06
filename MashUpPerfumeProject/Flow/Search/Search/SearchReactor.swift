//
//  SearchReactor.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/10/03.
//

import Foundation
import RxSwift
import ReactorKit

final class SearchReactor: Reactor {
    enum Action {
        case request
    }
    
    enum Mutation {
        case setIsLoading(Bool)
    }
    
    struct State {
        var isLoading = false
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .request:
            return Observable.concat([
                .just(.setIsLoading(true)),
            
                .just(.setIsLoading(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setIsLoading(isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
}
