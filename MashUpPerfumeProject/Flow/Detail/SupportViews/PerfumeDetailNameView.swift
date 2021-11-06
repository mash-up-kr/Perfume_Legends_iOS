//
//  PerfumeDetailNameView.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/06.
//

import UIKit

final class PerfumeDetailNameView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let brandLabel: UILabel = {
       let label = UILabel()
        label.textColor = .gray100
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "brandLabel"
        
        return label
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "titleLabel"
        
        return label
    }()
    
    private let ownCountLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.text = "0명이 이 향수를 가지고 있어요."
        
        return label
    }()
    
    private let diggingButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.layer.borderColor = UIColor(white: 0, alpha: 0.25).cgColor
        button.layer.borderWidth = 0.5
        
        return button
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
        addSubviews(stackView, diggingButton)
        stackView.addArrangedSubviews(brandLabel, titleLabel, ownCountLabel)

        stackView.setCustomSpacing(8, after: brandLabel)
        stackView.setCustomSpacing(12, after: titleLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: diggingButton.leadingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            diggingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            diggingButton.heightAnchor.constraint(equalToConstant: 50),
            diggingButton.widthAnchor.constraint(equalTo: diggingButton.heightAnchor),
            diggingButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
    }
}
