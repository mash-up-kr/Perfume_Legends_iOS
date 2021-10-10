//
//  NoteGroupReactor.swift
//  MashUpPerfumeProject
//
//  Created by 최원석 on 2021/10/03.
//

import Foundation
import RxSwift
import ReactorKit

final class NoteGroupReactor: Reactor {

    enum Action {
        case updateTitle(String?)
        case updateContent(String?)
        case updateCellModel([CellModel]?)
    }

    enum Mutation {
        case setTitle(String?)
        case setContent(String?)
        case setCellModel([CellModel]?)
    }

    struct State {
        var title: String?
        var content: String?
        var cellModel: [CellModel]?
    }

    let initialState = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateTitle(title):
            return .just(.setTitle(title))
        case let .updateContent(content):
            return .just(.setContent(content))
        case let .updateCellModel(cellModel):
            return .just(.setCellModel(cellModel))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case let .setTitle(title):
            newState.title = title
        case let .setContent(content):
            newState.content = content
        case let .setCellModel(cellModel):
            newState.cellModel = cellModel
        }

        return newState
    }
}
