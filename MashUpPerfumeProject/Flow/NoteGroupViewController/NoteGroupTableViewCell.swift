//
//  DefaultTableViewCell.swift
//  MashUpPerfumeProject
//
//  Created by 최원석 on 2021/10/10.
//

import UIKit

class NoteGroupTableViewCell: UITableViewCell {

    private var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)

        setConstraint()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setConstraint() {

        self.contentView.addSubview(self.baseView)
        self.baseView.addSubview(self.titleLabel)

        NSLayoutConstraint.activate([
            self.baseView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.baseView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.baseView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.baseView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            self.baseView.widthAnchor.constraint(equalToConstant: 335),
            self.baseView.heightAnchor.constraint(equalToConstant: 52),

            self.titleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 18),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }

    internal func configure(_ model: CellModel) {
        self.titleLabel.text = model.title
    }
}
