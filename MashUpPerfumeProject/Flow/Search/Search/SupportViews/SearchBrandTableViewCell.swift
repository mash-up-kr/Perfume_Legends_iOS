//
//  SearchBrandTableViewCell.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/13.
//

import UIKit
import Kingfisher

final class SearchBrandTableViewCell: UITableViewCell {
    private let brandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let brandNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray700
        label.text = "brandName"
        
        return label
    }()
    
    private let indicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_rightarrow_24")
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayout()
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setLayout()
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func setLayout() {
        contentView.addSubviews(brandImageView, brandNameLabel, indicatorImageView)
        
        NSLayoutConstraint.activate([
            brandImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            brandImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            brandImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            brandImageView.heightAnchor.constraint(equalToConstant: 48),
            brandImageView.widthAnchor.constraint(equalTo: brandImageView.heightAnchor),
            
            brandNameLabel.leadingAnchor.constraint(equalTo: brandImageView.trailingAnchor, constant: 12),
            brandNameLabel.centerYAnchor.constraint(equalTo: brandImageView.centerYAnchor),
            brandNameLabel.trailingAnchor.constraint(equalTo: indicatorImageView.leadingAnchor, constant: -12),
            
            indicatorImageView.heightAnchor.constraint(equalToConstant: 24),
            indicatorImageView.widthAnchor.constraint(equalTo: indicatorImageView.heightAnchor),
            indicatorImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            indicatorImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

extension SearchBrandTableViewCell {
    func configure(item: SearchResult.Item) {
        brandNameLabel.text = item.name
        if let imageURL = URL(string: item.thumbnailImageUrl) {
            brandImageView.kf.setImage(with: imageURL, placeholder: nil, options: nil, completionHandler: nil)
        }
    }
}
