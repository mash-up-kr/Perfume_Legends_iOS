//
//  BaseViewController.swift
//  MashUpPerfumeProject
//
//  Created by 선민승 on 2021/09/12.
//

import UIKit

class BaseViewController: UIViewController {

    let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Whitegray")
        setLayout()
    }
    
    func setLayout() { }

}

extension BaseViewController {
    func setIndicator() {
        view.addSubviews(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
