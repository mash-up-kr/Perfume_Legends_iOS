//
//  UnderlineButton.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/28.
//

import UIKit
import RxSwift
import RxCocoa

final class UnderlineButton: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        
        return label
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .skyBlue
        view.isHidden = true
        
        return view
    }()
    
    fileprivate let dummyButton = UIButton()
    
    var isSelected: Bool = false {
        didSet {
            guard oldValue != isSelected else { return }
            setSelected(isSelected: isSelected)
        }
    }
    
    var title: String? {
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setLayout()
    }
    
    private func setLayout() {
        addSubviews(titleLabel, underlineView, dummyButton)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        
            underlineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1),
            underlineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1),
            underlineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            underlineView.heightAnchor.constraint(equalToConstant: 2),
            
            heightAnchor.constraint(equalToConstant: 36),
            
            dummyButton.topAnchor.constraint(equalTo: topAnchor),
            dummyButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            dummyButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            dummyButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setSelected(isSelected: Bool) {
        underlineView.isHidden = !isSelected
        titleLabel.font = isSelected ? .systemFont(ofSize: 14, weight: .bold) : .systemFont(ofSize: 14, weight: .medium)
    }
}

extension Reactive where Base: UnderlineButton {
    var tap: ControlEvent<Void> {
        base.dummyButton.rx.tap
    }
}
