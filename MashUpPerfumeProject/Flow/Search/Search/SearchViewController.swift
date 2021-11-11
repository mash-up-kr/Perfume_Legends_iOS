//
//  SearchViewController.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/10/03.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

final class SearchViewController: BaseViewController, View {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "검색"
        
        return label
    }()
    
    private let textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let searchTextField: SearchTextField = {
        let textField = SearchTextField()
        textField.placeholder = "향수 이름, 브랜드 영문 입력"
        
        return textField
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.contentHorizontalAlignment = .trailing
        button.isHidden = true
        
        return button
    }()
    
    private let topDummyView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        
        return view
    }()
    
    private var collectionView: ContentsizedCollectionView = {

        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumInteritemSpacing = 12
        flowlayout.minimumLineSpacing = 12
        flowlayout.sectionInset = UIEdgeInsets(top: 28, left: 20, bottom: 26, right: 20)

        let itemWidth = ((UIScreen.main.bounds.width - 52) / 2)
        flowlayout.itemSize = CGSize(width: itemWidth, height: 104)

        let collectionView = ContentsizedCollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = .clear
//        collectionView.isScrollEnabled = false
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: "OnboardingCollectionViewCell")

//        collectionView.keyboardDismissMode = .onDrag
        return collectionView
    }()
    
    var disposeBag = DisposeBag()
    
    var isHiddenTitle: Bool = false {
        didSet {
            titleLabelTopConstraint?.isActive = !isHiddenTitle
            textFieldStackViewTopConstraint?.isActive = isHiddenTitle
            cancelButton.isHidden = !isHiddenTitle
            
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                self.collectionView.alpha = self.isHiddenTitle ? 0 : 1
                self.view.layoutIfNeeded()
            },
                           completion: { _ in
                
            })
        }
    }
    
    var titleLabelTopConstraint: NSLayoutConstraint?
    var textFieldStackViewTopConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
    
//        isHiddenTitle = true
    }
    
    override func setLayout() {
        super.setLayout()
        view.addSubviews(titleLabel, textFieldStackView, collectionView)
        view.addSubviews(topDummyView)
        textFieldStackView.addArrangedSubviews(searchTextField, cancelButton)
        
        
        titleLabelTopConstraint = titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 23)
        textFieldStackViewTopConstraint = textFieldStackView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 12)
        
        NSLayoutConstraint.activate([
            topDummyView.topAnchor.constraint(equalTo: view.topAnchor),
            topDummyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topDummyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topDummyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            titleLabelTopConstraint ?? NSLayoutConstraint(),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 34),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            textFieldStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 23),
            textFieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textFieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textFieldStackView.heightAnchor.constraint(equalToConstant: 44),
            
            cancelButton.widthAnchor.constraint(equalToConstant: 46),
            
            collectionView.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SearchViewController {
    func bind(reactor: SearchReactor) {
        searchTextField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] in
                self?.isHiddenTitle = true
            })
            .disposed(by: disposeBag)
        
        searchTextField.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext: { [weak self] in
                self?.isHiddenTitle = false
            })
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.view.endEditing(true)
                self?.searchTextField.text = nil
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.notes }
            .bind(to: collectionView.rx.items(cellIdentifier: "OnboardingCollectionViewCell", cellType:   OnboardingCollectionViewCell.self)) { index, element, cell in
                cell.configure(element)
            }.disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(OnboardingFourthViewController.CollectionViewModel.self)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.pushNoteGroupViewController(id: $0.id)
            })
            .disposed(by: disposeBag)
    }
}

extension SearchViewController {
    private func pushNoteGroupViewController(id: Int?) {
        let viewController = NoteGroupViewController()
        let reactor = NoteGroupReactor(id: id)
        viewController.reactor = reactor
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
