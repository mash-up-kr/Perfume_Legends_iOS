//
//  SearchFilterView.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/28.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchFilterView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 26
        
        return stackView
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        
        return view
    }()
    
    private let allButton: UnderlineButton = {
        let button = UnderlineButton()
        button.title = "전체"
        button.isSelected = true
        
        return button
    }()
    
    private let brandButton: UnderlineButton = {
        let button = UnderlineButton()
        button.title = "브랜드"
        
        return button
    }()
    
    private let perfumeButton: UnderlineButton = {
        let button = UnderlineButton()
        button.title = "제품"
        
        return button
    }()
    
    private let disposeBag = DisposeBag()
    
    fileprivate var filter: PublishRelay<SearchFilter> = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setLayout()
        bind()
    }
    
    
    private func setLayout() {
        addSubviews(lineView, stackView)
        stackView.addArrangedSubviews(allButton, brandButton, perfumeButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.5),
        ])
    }
    
    private func bind() {
        allButton.rx.tap
            .map { SearchFilter.all }
            .bind(to: filter)
            .disposed(by: disposeBag)

        brandButton.rx.tap
            .map { SearchFilter.brand }
            .bind(to: filter)
            .disposed(by: disposeBag)

        perfumeButton.rx.tap
            .map { SearchFilter.perfume }
            .bind(to: filter)
            .disposed(by: disposeBag)
        
        filter
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.allButton.isSelected = $0 == .all
                self.brandButton.isSelected = $0 == .brand
                self.perfumeButton.isSelected = $0 == .perfume
            })
            .disposed(by: disposeBag)
    }
}

extension Reactive where Base: SearchFilterView {
    var filter: PublishRelay<SearchFilter> {
        base.filter
    }
}
