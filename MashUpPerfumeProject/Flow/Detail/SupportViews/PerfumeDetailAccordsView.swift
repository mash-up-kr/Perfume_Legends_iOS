//
//  PerfumeDetailAccordsView.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/06.
//

import UIKit

final class PerfumeDetailAccordsView: UIView {
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "titleLabel"
        
        return label
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
        addSubviews(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
        ])
    }
}

