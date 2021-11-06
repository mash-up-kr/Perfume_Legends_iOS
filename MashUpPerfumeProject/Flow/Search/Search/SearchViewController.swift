//
//  SearchViewController.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/10/03.
//

import UIKit
import RxSwift
import ReactorKit

final class SearchViewController: BaseViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "검색"
        
        return label
    }()
    
    var disposeBag = DisposeBag()
}

extension SearchViewController {
    func bind(reactor: SearchReactor) {
        
    }
}
