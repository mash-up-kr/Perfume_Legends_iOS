//
//  NoteGroupViewController.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/01.
//

import UIKit
import RxSwift
import ReactorKit

final class NoteGroupViewController: BaseViewController, View {
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private let headerView = NoteGroupTableViewHeader()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "NOTE"
        
        tableView.tableHeaderView = headerView
        tableView.tableHeaderView?.widthAnchor.constraint(equalTo: tableView.widthAnchor).isActive = true
    }
    
    override func setLayout() {
        super.setLayout()
        view.addSubviews(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        setIndicator()
    }
}

extension NoteGroupViewController {
    func bind(reactor: NoteGroupReactor) {
        reactor.action.onNext(.requestNotes)
        
        reactor.state.compactMap { $0.noteGroup?.notes }
            .distinctUntilChanged()
            .bind(to: tableView.rx.items(cellIdentifier: NoteTableViewCell.reuseIdentifier, cellType: NoteTableViewCell.self)) { index, note, cell in
                cell.configure(note: note)
            }
            .disposed(by: disposeBag)
        
        reactor.state.compactMap { $0.noteGroup }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.headerView.setView(title: $0.name, description: $0.description, customName: $0.customName)
                self.headerView.layoutIfNeeded()
                self.tableView.reloadData()
//                self.tableView.contentInset.bottom = self.headerView.bounds.height
            })
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Note.self)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.pushNoteCollectionViewController(id: $0.id)
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }
        .distinctUntilChanged()
        .bind(to: activityIndicator.rx.isAnimating)
        .disposed(by: disposeBag)
    }
}

extension NoteGroupViewController {
    private func pushNoteCollectionViewController(id: Int) {
        let viewController = NoteCollectionViewController()
        let reactor = NoteCollectionReactor(id: id)
        viewController.reactor = reactor
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
