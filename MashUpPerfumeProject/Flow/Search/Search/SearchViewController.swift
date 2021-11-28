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
    
    private let noteCollectionBackgroundView = UIView()
    
    private let noteGroupCollectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "노트로 향수 찾기"
        
        return label
    }()
    
    private var collectionView: ContentsizedCollectionView = {

        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumInteritemSpacing = 12
        flowlayout.minimumLineSpacing = 12
        flowlayout.sectionInset = UIEdgeInsets(top: 28, left: 20, bottom: 26, right: 20)

        let itemWidth = ((UIScreen.main.bounds.width - 52) / 2)
        flowlayout.itemSize = CGSize(width: itemWidth, height: 104)

        let collectionView = ContentsizedCollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionView.backgroundColor = .clear
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier)

        return collectionView
    }()
    
    private let perfumeTableBackgroundView: UIView = {
        let view = UIView()
        view.isHidden = true
        
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.register(SearchBrandTableViewCell.self, forCellReuseIdentifier: SearchBrandTableViewCell.reuseIdentifier)
        tableView.register(SearchPerfumeTableViewCell.self, forCellReuseIdentifier: SearchPerfumeTableViewCell.reuseIdentifier)
        
        return tableView
    }()
    
    var disposeBag = DisposeBag()
    
    var isHiddenTitle: Bool = false {
        didSet {
            titleLabelTopConstraint?.isActive = !isHiddenTitle
            textFieldStackViewTopConstraint?.isActive = isHiddenTitle
            cancelButton.isHidden = !isHiddenTitle
            
            if isHiddenTitle {
                self.perfumeTableBackgroundView.isHidden = false
            } else {
                self.noteCollectionBackgroundView.isHidden = false
            }
            
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                self.noteCollectionBackgroundView.alpha = self.isHiddenTitle ? 0 : 1
                self.perfumeTableBackgroundView.alpha = self.isHiddenTitle ? 1 : 0
                self.view.layoutIfNeeded()
            },
                           completion: { _ in
                
                if self.isHiddenTitle {
                    self.noteCollectionBackgroundView.isHidden = true
                } else {
                    self.perfumeTableBackgroundView.isHidden = true
                }
            })
        }
    }
    
    var titleLabelTopConstraint: NSLayoutConstraint?
    var textFieldStackViewTopConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
//        navigationController?.setNavigationBarHidden(true, animated: false)
//        isHiddenTitle = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func setLayout() {
        super.setLayout()
        view.addSubviews(titleLabel, textFieldStackView, noteCollectionBackgroundView, perfumeTableBackgroundView)
        view.addSubviews(topDummyView)
        textFieldStackView.addArrangedSubviews(searchTextField, cancelButton)
        noteCollectionBackgroundView.addSubviews(noteGroupCollectionTitleLabel, collectionView)
        perfumeTableBackgroundView.addSubviews(tableView)
        
        
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
            
            noteCollectionBackgroundView.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor),
            noteCollectionBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noteCollectionBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noteCollectionBackgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            noteGroupCollectionTitleLabel.topAnchor.constraint(equalTo: noteCollectionBackgroundView.topAnchor, constant: 24),
            noteGroupCollectionTitleLabel.leadingAnchor.constraint(equalTo: noteCollectionBackgroundView.leadingAnchor, constant: 20),
            noteGroupCollectionTitleLabel.trailingAnchor.constraint(equalTo: noteCollectionBackgroundView.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: noteGroupCollectionTitleLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: noteCollectionBackgroundView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: noteCollectionBackgroundView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: noteCollectionBackgroundView.bottomAnchor),
                        
            perfumeTableBackgroundView.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor),
            perfumeTableBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            perfumeTableBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            perfumeTableBackgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: perfumeTableBackgroundView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: perfumeTableBackgroundView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: perfumeTableBackgroundView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: perfumeTableBackgroundView.bottomAnchor),
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
        
//        searchTextField.rx.controlEvent(.editingDidEnd)
//            .subscribe(onNext: { [weak self] in
//                self?.isHiddenTitle = false
//            })
//            .disposed(by: disposeBag)
        
        searchTextField.rx.text.changed
            .distinctUntilChanged()
            .throttle(.milliseconds(300), latest: true, scheduler: MainScheduler.asyncInstance)
            .map { Reactor.Action.requestSearch(text: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.view.endEditing(true)
                self?.searchTextField.text = nil
                self?.isHiddenTitle = false
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.notes }
        .bind(to: collectionView.rx.items(cellIdentifier: OnboardingCollectionViewCell.reuseIdentifier, cellType: OnboardingCollectionViewCell.self)) { index, element, cell in
            cell.configure(element)
        }.disposed(by: disposeBag)
        
        reactor.state.compactMap { $0.items }
        .distinctUntilChanged()
        .bind(to: tableView.rx.items) { tableView, row, element in
            let indexPath = IndexPath(row: row, section: 0)
            if element.type == .brand {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchBrandTableViewCell.reuseIdentifier, for: indexPath) as? SearchBrandTableViewCell else { return .init() }
                cell.configure(item: element)
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchPerfumeTableViewCell.reuseIdentifier, for: indexPath) as? SearchPerfumeTableViewCell else { return .init() }
                cell.configure(item: element)
                return cell
            }
        }
        .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(OnboardingFourthViewController.CollectionViewModel.self)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.pushNoteGroupViewController(id: $0.id)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(SearchResult.Item.self)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                switch $0.type {
                case .brand:
                    break
                case .perfume:
                    self.pushPerfumeDetailViewController(id: $0.id)
                case .none:
                    break
                }
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
    
    private func pushPerfumeDetailViewController(id: Int) {
        let viewController = PerfumeDetailViewController()
        let reactor = PerfumeDetailReactor(id: id)
        viewController.reactor = reactor
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}
