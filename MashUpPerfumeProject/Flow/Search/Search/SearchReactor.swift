//
//  SearchReactor.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/10/03.
//

import UIKit
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
        let notes: [OnboardingFourthViewController.CollectionViewModel] = [
            .init(image: UIImage(named: "citrus_yellow_32"), title: "CITRUS"),
            .init(image: UIImage(named: "fruits&vegetables _purple_32"), title: "FRUITS &\nVEGETABLE"),
            .init(image: UIImage(named: "flowers_pink_32"), title: "FLOWERS"),
            .init(image: UIImage(named: "whiteFlowers_skyblue_32"), title: "WHITE FLOWERS"),
            .init(image: UIImage(named: "greens_green_32"), title: "GREENS"),
            .init(image: UIImage(named: "spices_brown_32"), title: "SPICES"),
            .init(image: UIImage(named: "sweets&gourmand_pink_32"), title: "SWEETS &\nGOURMAND"),
            .init(image: UIImage(named: "woods_brown_32"), title: "WOODS"),
            .init(image: UIImage(named: "resins&balsams_brown_32"), title: "RESINS & BALSAMS"),
            .init(image: UIImage(named: "animalic_orange_32"), title: "ANIMALIC"),
            .init(image: UIImage(named: "beverages_red"), title: "BEVERAGES"),
            .init(image: UIImage(named: "natural&systhetic_blue_32"), title: "NATURAL &\nSYNTHETIC")
        ]
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
