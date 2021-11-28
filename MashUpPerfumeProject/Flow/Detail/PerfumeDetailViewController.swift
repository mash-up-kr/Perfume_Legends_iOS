//
//  PerfumeDetailViewController.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/06.
//

import UIKit
import RxSwift
import Kingfisher
import ReactorKit

final class PerfumeDetailViewController: BaseViewController, View {
    private let scrollView = UIScrollView()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()

    private let perfumeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let detailNameView = PerfumeDetailNameView()
    private let accordsView = PerfumeDetailAccordsView()
    private let notesView = PerfumeDetailNotesView()
    private let similarView = PerfumeDetailSimilarView()
    
//    private let
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func setLayout() {
        super.setLayout()
        view.addSubviews(scrollView)
        scrollView.addSubviews(stackView)
        stackView.addArrangedSubviews(perfumeImageView, detailNameView, accordsView, SeparatorView(), notesView, SeparatorView(), similarView)
        
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

extension PerfumeDetailViewController {
    func bind(reactor: PerfumeDetailReactor) {
        reactor.action.onNext(.requestPerfume)
        
        notesView.rx.note.compactMap { $0 }
            .distinctUntilChanged()
            .map { Reactor.Action.updateSelectedNote($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.compactMap { $0.perfumeDetail }
        .subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if let imageURL = URL(string: $0.imageUrl) {
                self.perfumeImageView.kf.setImage(with: imageURL)
            }
            self.detailNameView.setView(perfumeDetail: $0)
            self.similarView.setView(perfumeDetail: $0)
        })
        .disposed(by: disposeBag)
        
        reactor.state.compactMap { $0.perfumeDetail?.accords }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.accordsView.setView(accords: $0)
            })
            .disposed(by: disposeBag)
        
        reactor.state.compactMap { $0.notes }
        .bind(to: notesView.collectionView.rx.items(cellIdentifier: PerfumeDetailNotesView.NoteCell.reuseIdentifier, cellType: PerfumeDetailNotesView.NoteCell.self)) { index, element, cell in
            cell.configure(title: element)
        }
        .disposed(by: disposeBag)
        
    }
}

extension PerfumeDetailViewController {

}
