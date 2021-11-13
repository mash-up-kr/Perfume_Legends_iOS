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
        let notes: [OnboardingFourthViewController.CollectionViewModel] = [
            .init(image: UIImage(named: "citrus_yellow_32"), title: "CITRUS", id: 21180),
            .init(image: UIImage(named: "fruits&vegetables _purple_32"), title: "FRUITS &\nVEGETABLE", id: 21181),
            .init(image: UIImage(named: "flowers_pink_32"), title: "FLOWERS", id: 21182),
            .init(image: UIImage(named: "whiteFlowers_skyblue_32"), title: "WHITE FLOWERS", id: 21183),
            .init(image: UIImage(named: "greens_green_32"), title: "GREENS", id: 21184),
            .init(image: UIImage(named: "spices_brown_32"), title: "SPICES", id: 21185),
            .init(image: UIImage(named: "sweets&gourmand_pink_32"), title: "SWEETS &\nGOURMAND", id: 21186),
            .init(image: UIImage(named: "woods_brown_32"), title: "WOODS", id: 21187),
            .init(image: UIImage(named: "resins&balsams_brown_32"), title: "RESINS & BALSAMS", id: 21188),
            .init(image: UIImage(named: "animalic_orange_32"), title: "ANIMALIC", id: 21189),
            .init(image: UIImage(named: "beverages_red"), title: "BEVERAGES", id: 21190),
            .init(image: UIImage(named: "natural&systhetic_blue_32"), title: "NATURAL &\nSYNTHETIC", id: 21191)
        ]
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
                    .map {
                        log($0)
                        return Mutation.setSearchResult($0.items)
                    },
            
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
