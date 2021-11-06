//
//  NoteGroupViewController.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/01.
//

import UIKit
import RxSwift
import ReactorKit

final class NoteGroupViewController: BaseViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "검색"
        
        return label
    }()
    
    var disposeBag = DisposeBag()
}

extension NoteGroupViewController {
    func bind(reactor: SearchReactor) {
        
    }
}

