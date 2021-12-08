//
//  PerfumeListReactor.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/12/05.
//

import Foundation
import RxSwift
import Moya
import ReactorKit

final class PerfumeListReactor: Reactor {
    enum Action {
        case requestPerfumes
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
        case .requestPerfumes:
            return Observable.concat([
                .just(.setIsLoading(true)),
                
                getPerfumes(id: currentState.id)
                    .asObservable()
                    .map([SearchResult.Item].self, atKeyPath: "data.perfumes")
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

extension PerfumeListReactor {
    private func getPerfumes(id: Int) -> Single<Response>{
        APIService.shared.getPerfumes(brandId: id)
    }
}
