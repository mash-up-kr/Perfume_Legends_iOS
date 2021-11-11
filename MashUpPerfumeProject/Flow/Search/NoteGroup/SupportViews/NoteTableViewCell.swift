//
//  NoteTableViewCell.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/12.
//

import UIKit

final class NoteTableViewCell: UITableViewCell {
    static let reuseIdentifier = "NoteTableViewCell"
    
    private let cellBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray700
        
        return label
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
        contentView.addSubviews(cellBackgroundView)
        cellBackgroundView.addSubviews(titleLabel)
        
        NSLayoutConstraint.activate([
            cellBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cellBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -18),
            titleLabel.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor, constant: -15)
        ])
    }
}

extension NoteTableViewCell {
    func configure(note: Note) {
        titleLabel.text = note.name
    }
}
