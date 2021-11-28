//
//  SearchReactor.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/10/03.
//

import UIKit
import RxSwift
import ReactorKit
import Moya

final class SearchReactor: Reactor {
    enum Action {
        case requestSearch(text: String?)
    }
    
    enum Mutation {
        case setSearchResult([SearchResult.Item])
        case setIsLoading(Bool)
    }
    
    struct State {
        var notes: [NoteGroup] = []
        var items: [SearchResult.Item]?
        var isLoading = false
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .requestSearch(query):
            guard let query = query, query != "" else { return .just(.setSearchResult([])) }
            return Observable.concat([
                .just(.setIsLoading(true)),
                
                requestSearch(query: query)
                    .asObservable()
                    .map(SearchResult.self, atKeyPath: "data", using: JSONDecoder(), failsOnEmptyData: false)
                    .map { Mutation.setSearchResult($0.items) },
            
                .just(.setIsLoading(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setSearchResult(items):
            newState.items = items
            
        case let .setIsLoading(isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
}

extension SearchReactor {
    private func requestSearch(query: String) -> Single<Response> {
        APIService.shared.requestSearch(query: query)
    }
}
