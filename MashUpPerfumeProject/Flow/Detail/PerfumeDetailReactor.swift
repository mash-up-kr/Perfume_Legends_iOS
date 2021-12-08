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
        case updateSelectedNote(NoteCase)
    }
    
    enum Mutation {
        case setSeletedNote(NoteCase)
        case setPefumeDetail(PerfumeDetail)
        case setIsLoading(Bool)
    }
    
    struct State {
        let id: Int
        
        var selectedNote: NoteCase = .top
        var notes: [String]?
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
                    .map {
                        log(String(data: $0.data, encoding: .utf8))
                        return $0
                    }
                    .map(PerfumeDetail.self, atKeyPath: "data.perfumeDetail")
                    .map { Mutation.setPefumeDetail($0) }
                    .catch {
                        log($0)
                        return .just(.setIsLoading(false))
                    },
            
                .just(.setIsLoading(false))
            ])
            
        case let .updateSelectedNote(selectedNote):
            return .just(.setSeletedNote(selectedNote))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setPefumeDetail(perfumeDetail):
            log(perfumeDetail)
            newState.perfumeDetail = perfumeDetail
            newState.notes = perfumeDetail.notes.top
            
        case let .setSeletedNote(selectedNote):
            newState.selectedNote = selectedNote
            switch selectedNote {
            case .top:
                newState.notes = newState.perfumeDetail?.notes.top
            case .base:
                newState.notes = newState.perfumeDetail?.notes.base
            case .middle:
                newState.notes = newState.perfumeDetail?.notes.middle
            case .unknown:
                break
            }
            
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
