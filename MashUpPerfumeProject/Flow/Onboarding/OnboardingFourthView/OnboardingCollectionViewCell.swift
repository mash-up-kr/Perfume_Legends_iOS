//
//  OnboardingCollectionViewCell.swift
//  MashUpPerfumeProject
//
//  Created by 최원석 on 2021/10/25.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "citrus_yellow_32")
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)
        label.numberOfLines = 0
        return label
    }()

    override var isSelected: Bool {
        didSet {
            let selectBorderColor = UIColor(red: 131/255, green: 218/255, blue: 255/255, alpha: 1)
            let normalBorderColor = UIColor.white

            if isSelected {
                self.contentView.layer.borderColor = isSelected ? selectBorderColor.cgColor : normalBorderColor.cgColor
                self.titleLabel.textColor = .black
            } else {
                self.contentView.layer.borderColor = isSelected ? selectBorderColor.cgColor : normalBorderColor.cgColor
                self.titleLabel.textColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setView()
        setLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setView() {
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.cornerRadius = 8
        self.contentView.backgroundColor = .white
        self.contentView.layer.borderColor = UIColor.white.cgColor
    }

    private func setLayout() {
        self.contentView.addSubview(self.imageView ,self.titleLabel)

        NSLayoutConstraint.activate([

            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            self.imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),

            self.titleLabel.centerYAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 25),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }

    internal func configure(_ model: OnboardingFourthViewController.CollectionViewModel) {
        self.imageView.image = model.image
        self.titleLabel.text = model.title
    }
}
