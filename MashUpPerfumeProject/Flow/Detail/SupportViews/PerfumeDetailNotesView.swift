//
//  PerfumeDetailNotesView.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/06.
//

import UIKit

final class PerfumeDetailNotesView: UIView {
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "향수 노트"
        
        return label
    }()
    
    private let noteButton = NoteButton()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setLayout()
    }
    
    private func setLayout() {
        addSubviews(titleLabel, noteButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            noteButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            noteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            noteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}

extension PerfumeDetailNotesView {
    final class NoteButton: UIView {
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
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setLayout()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            
            setLayout()
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
    }
}
