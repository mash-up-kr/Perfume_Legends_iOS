//
//  NoteGroupViewController.swift
//  MashUpPerfumeProject
//
//  Created by 최원석 on 2021/10/03.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import Moya
import RxMoya

class NoteGroupViewController: BaseViewController, View {

    private var testCellModel = Observable<[CellModel]>.of([CellModel(title: "Lisbon"), CellModel(title: "Copenhagen"), CellModel(title: "London"), CellModel(title: "Madrid"), CellModel(title: "Vienna"), CellModel(title: "Vienna"), CellModel(title: "Vienna"), CellModel(title: "Vienna"), CellModel(title: "Vienna"), CellModel(title: "Vienna"), CellModel(title: "Vienna"), CellModel(title: "Vienna"), CellModel(title: "Vienna"), CellModel(title: "Vienna"), CellModel(title: "Vienna"), CellModel(title: "Vienna")])

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    private let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "CITRUS"
        return label
    }()

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "The citrus essences are expressed or cold-expressed in most cases to preserve their inherent freshness. Petitgrain is an exception, as it comes from the steam distillation of the twigs and leaves of the bitter orange tree"
        return label
    }()

    private let tableView: DynamicTableView = {
        let tableView = DynamicTableView()
        tableView.register(NoteGroupTableViewCell.self, forCellReuseIdentifier: "NoteGroupTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        return tableView
    }()

    var disposeBag = DisposeBag()

    override func setLayout() {
        super.setLayout()

        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.baseView)
        self.baseView.addSubview( self.titleLabel, self.contentLabel, self.tableView)

        NSLayoutConstraint.activate([

            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),

            self.baseView.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor, constant: 0),
            self.baseView.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor, constant: 0),
            self.baseView.trailingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.trailingAnchor, constant: 0),
            self.baseView.bottomAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.bottomAnchor, constant: 0),
            self.baseView.widthAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.widthAnchor),
            self.baseView.heightAnchor.constraint(lessThanOrEqualToConstant: 2000),

            self.titleLabel.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 90),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 38),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -38),

            self.contentLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 18),
            self.contentLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 38),
            self.contentLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -38),

            self.tableView.topAnchor.constraint(equalTo: self.contentLabel.bottomAnchor, constant: 23),
            self.tableView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 0),
            self.tableView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: 0),
            self.tableView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: 0)
        ])
    }
}

extension NoteGroupViewController {
    func bind(reactor: NoteGroupReactor) {

        self.testCellModel.bind(to: self.tableView.rx.items(cellIdentifier: "NoteGroupTableViewCell", cellType: NoteGroupTableViewCell.self)) {
             index, element, cell in
            cell.configure(element)
        }.disposed(by: self.disposeBag)
    }

    // 궁금한것들
    // 1. 가데이터로 테스트 하는 방법
}
