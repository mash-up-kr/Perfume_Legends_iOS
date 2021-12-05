//
//  PerfumeListViewController.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/12/05.
//

import UIKit
import RxSwift
import ReactorKit

final class PerfumeListViewController: BaseViewController, View {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.register(SearchPerfumeTableViewCell.self, forCellReuseIdentifier: SearchPerfumeTableViewCell.reuseIdentifier)
        tableView.contentInset.top = 20
        
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    var disposeBag = DisposeBag()
    
    override func setLayout() {
        super.setLayout()
        view.addSubviews(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        setIndicator()
    }
}

extension PerfumeListViewController {
    func bind(reactor: PerfumeListReactor) {
        reactor.action.onNext(.requestPerfumes)
    
        reactor.state.compactMap { $0.perfumes }
            .distinctUntilChanged()
            .bind(to: tableView.rx.items) { tableView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchPerfumeTableViewCell.reuseIdentifier, for: indexPath) as? SearchPerfumeTableViewCell else { return .init() }
                cell.configure(item: element)
                return cell
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }
        .distinctUntilChanged()
        .bind(to: activityIndicator.rx.isAnimating)
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(SearchResult.Item.self)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.pushPerfumeDetailViewController(id: $0.id)
            })
            .disposed(by: disposeBag)
    }
}

extension PerfumeListViewController {
    private func pushPerfumeDetailViewController(id: Int) {
        let viewController = PerfumeDetailViewController()
        let reactor = PerfumeDetailReactor(id: id)
        viewController.reactor = reactor
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
