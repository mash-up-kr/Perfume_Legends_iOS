//
//  SeparatorView.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/06.
//

import UIKit

final class SeparatorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .whiteGray
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = .whiteGray
        setLayout()
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 8)
        ])
    }
}
