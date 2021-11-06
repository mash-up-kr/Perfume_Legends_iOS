//
//  PerfumeDetailViewController.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/06.
//

import UIKit
import RxSwift
import ReactorKit

final class PerfumeDetailViewController: BaseViewController {
    private let scrollView = UIScrollView()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let perfumeImageView = UIImageView()
    
    private let detailNameView = PerfumeDetailNameView()
    
//    private let
    var disposeBag = DisposeBag()
    
    override func setLayout() {
        super.setLayout()
        view.addSubviews(scrollView)
        scrollView.addSubviews(stackView)
        stackView.addArrangedSubviews(perfumeImageView, detailNameView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            perfumeImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            perfumeImageView.heightAnchor.constraint(equalTo: perfumeImageView.widthAnchor, multiplier: 306/355),
        ])
    }
}

extension NoteCollectionViewController {
    func bind(reactor: PerfumeDetailReactor) {
        
    }
}
