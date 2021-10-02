//
//  NewReactor.swift
//  MashUpPerfumeProject
//
//  Created by 선민승 on 2021/09/12.
//

import Foundation
import RxSwift
import ReactorKit

final class NewReactor: Reactor {
    
    enum Action { // 정의만 한다
        case updateID(String?)
        case updatePassword(String?)
    }
    
    enum Mutation {
        case setID(String?)
        case setPassword(String?)
    }
    
    struct State {
        var id: String?
        var password: String?
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateID(id):
            return .just(.setID(id))
        case let .updatePassword(password):
            return .just(.setPassword(password))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setID(id):
            newState.id = id
        case let .setPassword(password):
            newState.password = password
        }
        
        return newState
    }
}
