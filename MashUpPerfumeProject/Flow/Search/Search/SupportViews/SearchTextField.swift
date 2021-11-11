//
//  SearchTextField.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/10.
//

import UIKit

final class SearchTextField: UITextField {
    private let searchImageBackgroundView = UIView()
    private let searchImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setInitialView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setInitialView()
        setLayout()
    }
    
    private func setInitialView() {
        backgroundColor = .white
        layer.cornerRadius = 4
        textColor = .black
        font = .systemFont(ofSize: 14, weight: .medium)
        leftViewMode = .always
        clearButtonMode = .whileEditing
        searchImageView.image = UIImage(named: "ic_search_black_20")
    }
    
    private func setLayout() {
        leftView = searchImageBackgroundView
        searchImageBackgroundView.addSubviews(searchImageView)
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 44),
        
            searchImageView.leadingAnchor.constraint(equalTo: searchImageBackgroundView.leadingAnchor, constant: 12),
            searchImageView.trailingAnchor.constraint(equalTo: searchImageBackgroundView.trailingAnchor, constant: -12),
            searchImageView.centerYAnchor.constraint(equalTo: searchImageBackgroundView.centerYAnchor),
            searchImageView.widthAnchor.constraint(equalToConstant: 20),
            searchImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
