//
//  PerfumeDetailSimilarView.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/06.
//

import UIKit

final class PerfumeDetailSimilarView: UIView {
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "이 향수와 비슷한 제품"
        
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let perfumeViews = [PerfumeView(), PerfumeView(), PerfumeView()]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setLayout()
    }
    
    private func setLayout() {
        addSubviews(titleLabel, stackView)
        stackView.addArrangedSubviews(perfumeViews)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 167),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            
        ])
    }
}

extension PerfumeDetailSimilarView {
    func setView(perfumeDetail: PerfumeDetail) {
        perfumeDetail.similarPerfumes.enumerated().forEach {
            self.perfumeViews[$0.offset].setView(item: $0.element)
        }
    }
}

extension PerfumeDetailSimilarView {
    private final class PerfumeView: UIView {
        private let perfumeImageView = UIImageView()
        
        private let brandLabel: UILabel = {
           let label = UILabel()
            label.textColor = .gray200
            label.font = .systemFont(ofSize: 12)
            label.text = "brandLabel"
            label.textAlignment = .center
            
            return label
        }()
        
        private let titleLabel: UILabel = {
           let label = UILabel()
            label.textColor = .black
            label.font = .systemFont(ofSize: 12, weight: .medium)
            label.text = "titleLabel"
            label.textAlignment = .center
            label.numberOfLines = 2
            
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
            addSubviews(perfumeImageView, brandLabel, titleLabel)
            
            NSLayoutConstraint.activate([
                perfumeImageView.topAnchor.constraint(equalTo: topAnchor),
                perfumeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                perfumeImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                perfumeImageView.heightAnchor.constraint(equalToConstant: 105),
                perfumeImageView.widthAnchor.constraint(equalTo: perfumeImageView.heightAnchor),
                
                brandLabel.topAnchor.constraint(equalTo: perfumeImageView.bottomAnchor,constant: 8),
                brandLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                brandLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                
                titleLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
        }
        
        func setView(item: PerfumeDetail.Item) {
            titleLabel.text = item.name
            if let imageURL = URL(string: item.image) {
                perfumeImageView.kf.setImage(with: imageURL, placeholder: nil, options: nil, completionHandler: nil)
            }
        }
    }
}
