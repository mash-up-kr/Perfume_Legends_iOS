//
//  NoteCollectionViewController.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/01.
//

import UIKit
import RxSwift
import ReactorKit

final class NoteCollectionViewController: BaseViewController, View {
    private var collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumInteritemSpacing = 12
        flowlayout.minimumLineSpacing = 24
        flowlayout.sectionInset = UIEdgeInsets(top: 28, left: 20, bottom: 26, right: 20)

        let itemWidth = ((UIScreen.main.bounds.width - 52) / 2)
        flowlayout.itemSize = CGSize(width: itemWidth, height: 230)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionView.backgroundColor = .clear
        collectionView.register(PerfumeCollectionViewCell.self, forCellWithReuseIdentifier: PerfumeCollectionViewCell.reuseIdentifier)

        return collectionView
    }()
    
    var disposeBag = DisposeBag()
    
    override func setLayout() {
        super.setLayout()
        view.addSubviews(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension NoteCollectionViewController {
    func bind(reactor: NoteCollectionReactor) {
        reactor.action.onNext(.requestNotePerfumes)
        
        reactor.state.compactMap { $0.perfumes }
        .distinctUntilChanged()
        .bind(to: collectionView.rx.items(cellIdentifier: PerfumeCollectionViewCell.reuseIdentifier, cellType: PerfumeCollectionViewCell.self)) { index, element, cell in
            cell.configure(item: element)
        }
        .disposed(by: disposeBag)
    }
}


