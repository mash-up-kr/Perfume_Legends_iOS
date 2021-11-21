//
//  PerfumeDetailReactor.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/06.
//

import Foundation
import RxSwift
import Moya
import ReactorKit

final class PerfumeDetailReactor: Reactor {
    enum Action {
        case requestPerfume
    }
    
    enum Mutation {
        case setPefumeDetail(PerfumeDetail)
        case setIsLoading(Bool)
    }
    
    struct State {
        let id: Int
        
        var perfumeDetail: PerfumeDetail?
        var isLoading = false
    }
    
    let initialState: State
    
    init(id: Int) {
        initialState = State(id: id)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .requestPerfume:
            return Observable.concat([
                .just(.setIsLoading(true)),
                
                requestPerfume(id: currentState.id)
                    .asObservable()
                    .map(PerfumeDetail.self, atKeyPath: "data.perfumeDetail")
                    .map { Mutation.setPefumeDetail($0) }
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
        case let .setPefumeDetail(perfumeDetail):
            log(perfumeDetail)
            newState.perfumeDetail = perfumeDetail
            
        case let .setIsLoading(isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
}

extension PerfumeDetailReactor {
    private func requestPerfume(id: Int) -> Single<Response> {
        APIService.shared.requestPerfume(id: id)
    }
}
