//
//  SearchPerfumeTableViewCell.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/13.
//

import UIKit

final class SearchPerfumeTableViewCell: UITableViewCell {
    private let perfumeImageView = UIImageView()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray700
        label.text = "brandName"
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray700
        label.text = "brandName"
        label.numberOfLines = 2
        
        return label
    }()
    
    private let perfumeBackgroundView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setLayout() {
        contentView.addSubviews(perfumeBackgroundView)
        perfumeBackgroundView.addSubviews(perfumeImageView, brandLabel, titleLabel)
        
        NSLayoutConstraint.activate([
            perfumeBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            perfumeBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            perfumeBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            perfumeBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            perfumeImageView.topAnchor.constraint(equalTo: perfumeBackgroundView.topAnchor, constant: 7),
            perfumeImageView.leadingAnchor.constraint(equalTo: perfumeBackgroundView.leadingAnchor, constant: 7),
            perfumeImageView.bottomAnchor.constraint(equalTo: perfumeBackgroundView.bottomAnchor, constant: -7),
            perfumeImageView.heightAnchor.constraint(equalToConstant: 80),
            perfumeImageView.widthAnchor.constraint(equalTo: perfumeImageView.heightAnchor),
        
            brandLabel.topAnchor.constraint(equalTo: perfumeBackgroundView.topAnchor, constant: 30),
            brandLabel.leadingAnchor.constraint(equalTo: perfumeImageView.trailingAnchor, constant: 16),
            brandLabel.trailingAnchor.constraint(equalTo: perfumeBackgroundView.trailingAnchor, constant: -12),
            
            titleLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: brandLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: brandLabel.trailingAnchor),
        ])
    }
}
