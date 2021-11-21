//
//  SearchPerfumeTableViewCell.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/13.
//

import UIKit
import Kingfisher

final class SearchPerfumeTableViewCell: UITableViewCell {
    private let perfumeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .gray100
        label.text = "brandName"
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.text = "brandName"
        
        return label
    }()
    
    private let perfumeBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        
        return view
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
            brandLabel.trailingAnchor.constraint(equalTo: perfumeBackgroundView.trailingAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: brandLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: brandLabel.trailingAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        perfumeImageView.kf.cancelDownloadTask()
        perfumeImageView.image = nil
    }
}

extension SearchPerfumeTableViewCell {
    func configure(item: SearchResult.Item) {
        titleLabel.text = item.name
        if let imageURL = URL(string: item.thumbnailImageUrl) {
            perfumeImageView.kf.setImage(with: imageURL, placeholder: nil, options: nil, completionHandler: nil)
        }
    }
}

