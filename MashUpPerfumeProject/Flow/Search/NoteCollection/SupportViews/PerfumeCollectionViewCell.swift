//
//  PerfumeCollectionViewCell.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/22.
//

import UIKit
import Kingfisher

final class PerfumeCollectionViewCell: UICollectionViewCell {
    private let perfumeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .gray100
        label.text = "brandName"
        label.textAlignment = .center
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.text = "brandName"
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        perfumeImageView.layer.cornerRadius = 8
        perfumeImageView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setLayout()
        perfumeImageView.layer.cornerRadius = 8
        perfumeImageView.clipsToBounds = true
    }
    
    private func setLayout() {
        contentView.addSubviews(perfumeImageView, brandLabel, titleLabel)
        
        NSLayoutConstraint.activate([
            perfumeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            perfumeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            perfumeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            perfumeImageView.heightAnchor.constraint(equalTo: perfumeImageView.widthAnchor),
            
            brandLabel.topAnchor.constraint(equalTo: perfumeImageView.bottomAnchor, constant: 8),
            brandLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            brandLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 2),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        perfumeImageView.kf.cancelDownloadTask()
        perfumeImageView.image = nil
    }
}

extension PerfumeCollectionViewCell {
    func configure(item: SearchResult.Item) {
        titleLabel.text = item.name
        brandLabel.text = item.brandName
        if let imageURL = URL(string: item.thumbnailImageUrl) {
            perfumeImageView.kf.setImage(with: imageURL, placeholder: nil, options: nil, completionHandler: nil)
        }
    }
}

