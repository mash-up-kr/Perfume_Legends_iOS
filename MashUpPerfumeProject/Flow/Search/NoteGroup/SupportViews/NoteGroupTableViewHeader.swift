//
//  NoteGroupTableViewHeader.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/13.
//

import UIKit
import Kingfisher

final class NoteGroupTableViewHeader: UIView {
    private let noteImageView = UIImageView()
    
    private let noteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        label.text = "noteLabel"
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray700
        label.text = "descriptionLabel"
        label.numberOfLines = 3
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setLayout()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setLayout() {
        addSubviews(noteImageView, noteLabel, descriptionLabel)
        
        NSLayoutConstraint.activate([
            noteImageView.centerYAnchor.constraint(equalTo: noteLabel.centerYAnchor),
            noteImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            noteImageView.heightAnchor.constraint(equalToConstant: 32),
            noteImageView.widthAnchor.constraint(equalTo: noteImageView.heightAnchor),
            
            noteLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            noteLabel.leadingAnchor.constraint(equalTo: noteImageView.trailingAnchor, constant: 8),
            noteLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -38)
        ])
    }
}

extension NoteGroupTableViewHeader {
    func setView(title: String, description: String, customName: String) {
        noteLabel.text = title
        descriptionLabel.text = description
        noteImageView.image = UIImage(named: customName)
//        if let url = URL(string: imageURL) {
//            noteImageView.kf.setImage(with: url)
//        }
    }
}
