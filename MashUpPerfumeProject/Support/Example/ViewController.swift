//
//  ViewController.swift
//  MashUpPerfumeProject
//
//  Created by 선민승 on 2021/09/07.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import Moya
import RxMoya


class ViewController: BaseViewController, View {
    let provider = MoyaProvider<APITarget>()

    private let idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "id"
        textField.borderStyle = .line
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password"
        textField.borderStyle = .line
        
        return textField
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.backgroundColor = .gray
        
        return button
    }()
        
    var disposeBag = DisposeBag()
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
    override func setLayout() {
        super.setLayout()
        view.addSubviews(idTextField, passwordTextField, confirmButton)

        NSLayoutConstraint.activate([
            idTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            idTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            idTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            passwordTextField.topAnchor.constraint(equalTo: idTextField.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: idTextField.safeAreaLayoutGuide.trailingAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: idTextField.safeAreaLayoutGuide.leadingAnchor),
            
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            confirmButton.trailingAnchor.constraint(equalTo: idTextField.safeAreaLayoutGuide.trailingAnchor),
            confirmButton.leadingAnchor.constraint(equalTo: idTextField.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
}

extension ViewController {
    func bind(reactor: NewReactor) {
        idTextField.rx.text
            .map { return Reactor.Action.updateID($0)} // 스트림에서 action 으로 바꾸었음
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .map { return Reactor.Action.updatePassword($0)} // 스트림에서 action 으로 바꾸었음
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { ($0.id == "") || ($0.password == "") }
            .subscribe(onNext: { isEmpty in
                self.confirmButton.backgroundColor = isEmpty ? .gray : .blue
            })
            .disposed(by: disposeBag)
    }
}
