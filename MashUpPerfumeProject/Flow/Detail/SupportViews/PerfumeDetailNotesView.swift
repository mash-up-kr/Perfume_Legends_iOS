//
//  PerfumeDetailNotesView.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/06.
//

import UIKit
import RxSwift
import RxCocoa

final class PerfumeDetailNotesView: UIView {
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "향수 노트"
        
        return label
    }()
    
    fileprivate let noteButton = NoteButton()
    
    var collectionView: ContentsizedCollectionView = {

        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumInteritemSpacing = 18
        flowlayout.minimumLineSpacing = 18
        flowlayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

        let itemWidth = ((UIScreen.main.bounds.width - 76) / 3)
        flowlayout.itemSize = CGSize(width: itemWidth, height: 45)

        let collectionView = ContentsizedCollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionView.backgroundColor = .clear
        collectionView.register(NoteCell.self, forCellWithReuseIdentifier: NoteCell.reuseIdentifier)

        return collectionView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setLayout()
    }
    
    private func setLayout() {
        addSubviews(titleLabel, noteButton, collectionView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            noteButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            noteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            collectionView.topAnchor.constraint(equalTo: noteButton.bottomAnchor, constant: 32),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
    }
}

extension Reactive where Base: PerfumeDetailNotesView {
    var note: PublishRelay<NoteCase?> {
        base.noteButton.note
    }
}

extension PerfumeDetailNotesView {
    fileprivate final class NoteButton: UIView {
        private let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 8
            
            return stackView
        }()
            
        private let topButton: UIButton = {
            let button = UIButton()
            button.setTitle("Top", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.layer.cornerRadius = 8
            
            return button
        }()
        
        private let middleButton: UIButton = {
            let button = UIButton()
            button.setTitle("Middle", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.layer.cornerRadius = 8
            
            return button
        }()
        
        private let baseButton: UIButton = {
            let button = UIButton()
            button.setTitle("Base", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.layer.cornerRadius = 8
            
            return button
        }()
        
        private var disposeBag = DisposeBag()
        
        var note: PublishRelay<NoteCase?> = .init()
        
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
            addSubviews(stackView)
            stackView.addArrangedSubviews(topButton, middleButton, baseButton)
            
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: topAnchor),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                topButton.heightAnchor.constraint(equalToConstant: 36),
                topButton.widthAnchor.constraint(equalToConstant: 80),
                
                middleButton.heightAnchor.constraint(equalTo: topButton.heightAnchor),
                middleButton.widthAnchor.constraint(equalTo: topButton.widthAnchor),
                
                baseButton.heightAnchor.constraint(equalTo: topButton.heightAnchor),
                baseButton.widthAnchor.constraint(equalTo: topButton.widthAnchor),
            ])
            
            setButtonState(topButton, isSelected: true)
            setButtonState(middleButton, isSelected: false)
            setButtonState(baseButton, isSelected: false)
        }
        
        private func setButtonState(_ button: UIButton, isSelected: Bool) {
            button.backgroundColor = isSelected ? .skyBlue : .clear
            button.setTitleColor(isSelected ? .white : .gray200 , for: .normal)
            button.layer.borderWidth = isSelected ? .zero : 1
            button.layer.borderColor = isSelected ? nil : UIColor.gray100.cgColor
            button.titleLabel?.font = .systemFont(ofSize: 14, weight: isSelected ? .bold : .regular)
        }
        
        private func bind() {
            topButton.rx.tap
                .map { NoteCase.top }
                .bind(to: note)
                .disposed(by: disposeBag)
            
            middleButton.rx.tap
                .map { NoteCase.middle }
                .bind(to: note)
                .disposed(by: disposeBag)
            
            baseButton.rx.tap
                .map { NoteCase.base }
                .bind(to: note)
                .disposed(by: disposeBag)
            
            note
                .distinctUntilChanged()
                .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.setButtonState(self.topButton, isSelected: $0 == .top)
                    self.setButtonState(self.middleButton, isSelected: $0 == .middle)
                    self.setButtonState(self.baseButton, isSelected: $0 == .base)
                })
                .disposed(by: disposeBag)
        }
    }
}

extension PerfumeDetailNotesView {
    final class NoteCell: UICollectionViewCell {
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = .systemFont(ofSize: 14)
            label.numberOfLines = 2
            label.textAlignment = .center
            
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setLayout()
            layer.cornerRadius = 8
            backgroundColor = .whiteGray
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            
            setLayout()
            layer.cornerRadius = 8
            backgroundColor = .whiteGray
        }
        
        private func setLayout() {
            contentView.addSubviews(titleLabel)
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ])
        }
        
        func configure(title: String?) {
            titleLabel.text = title
        }
    }
}
