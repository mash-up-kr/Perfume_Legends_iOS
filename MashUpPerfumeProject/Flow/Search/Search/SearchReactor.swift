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
        case requestNoteGroups
        case requestSearch(text: String?)
        case requestChangeFilter(SearchFilter)
        case requestResetSearch
    }
    
    enum Mutation {
        case setNoteGroups([NoteGroup])
        case setSearchResult([SearchResult.Item])
        case setQuery(String?)
        case setFilter(SearchFilter)
        case setResetSearch
        case setIsLoading(Bool)
    }
    
    struct State {
        var noteGroups: [NoteGroup] = []
        var query: String?
        var filter: SearchFilter = .all
        var items: [SearchResult.Item]?
        var isLoading = false
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .requestNoteGroups:

            return Observable.concat([
                .just(.setIsLoading(true)),

                APIService.shared.getNoteGroups()
                    .asObservable()
                    .map {
                        log(String(data: $0.data, encoding: .utf8))
                        return $0
                    }
                    .map([NoteGroup].self, atKeyPath: "data.noteGroups")
                    .map { Mutation.setNoteGroups($0) },

                .just(.setIsLoading(false))
            ])
            
        case let .requestSearch(query):
            guard let query = query, query != "" else { return .just(.setSearchResult([])) }
            return Observable.concat([
                .just(.setIsLoading(true)),
                
                requestSearch(query: query, filter: currentState.filter)
                    .asObservable()
                    .map {
                        log(String(data: $0.data, encoding: .utf8))
                        return $0
                    }
                    .map(SearchResult.self, atKeyPath: "data", using: JSONDecoder(), failsOnEmptyData: false)
                    .map { Mutation.setSearchResult($0.items) },
                
                .just(.setQuery(query)),
            
                .just(.setIsLoading(false))
            ])
            
        case let .requestChangeFilter(filter):
            guard let query = currentState.query, query != "" else { return .just(.setSearchResult([])) }
            log(filter.rawValue)
            return Observable.concat([
                .just(.setIsLoading(true)),
                
                requestSearch(query: query, filter: filter)
                    .asObservable()
                    .map {
                        log(String(data: $0.data, encoding: .utf8))
                        return $0
                    }
                    .map(SearchResult.self, atKeyPath: "data", using: JSONDecoder(), failsOnEmptyData: false)
                    .map { Mutation.setSearchResult($0.items) },
                
                .just(.setFilter(filter)),
            
                .just(.setIsLoading(false))
            ])
            
        case .requestResetSearch:
            return .just(.setResetSearch)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setNoteGroups(noteGroups):
            newState.noteGroups = noteGroups
            
        case let .setQuery(query):
            newState.query = query
            
        case let .setFilter(filter):
            newState.filter = filter
            
        case let .setSearchResult(items):
            newState.items = items
            
        case .setResetSearch:
            newState.query = nil
            newState.filter = .all
            newState.items = nil
            
        case let .setIsLoading(isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
}

extension SearchReactor {
    private func requestSearch(query: String, filter: SearchFilter) -> Single<Response> {
        APIService.shared.requestSearch(query: query, filter: filter)
    }
}
