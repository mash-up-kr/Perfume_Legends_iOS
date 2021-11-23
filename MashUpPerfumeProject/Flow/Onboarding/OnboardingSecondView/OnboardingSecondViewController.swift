//
//  OnboardingSecondViewController.swift
//  MashUpPerfumeProject
//
//  Created by 최원석 on 2021/10/19.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import Moya
import RxMoya

class OnboardingSecondViewController: BaseViewController, View {

    let provider = MoyaProvider<APITarget>()

    private let setiondotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Sectin_dot_1")
        return imageView
    }()

    private let mainLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "사용하실\n닉네임을 입력해주세요."
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        let attrString = NSMutableAttributedString(string: label.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        label.attributedText = attrString
        return label
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.backgroundColor = UIColor(named: "White")
        textField.layer.borderWidth = 1

        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        textField.attributedPlaceholder = NSAttributedString(
            string: "2~6자까지 입력이 가능해요.",
            attributes: [.paragraphStyle: centeredParagraphStyle])
        textField.textAlignment = NSTextAlignment.center
        return textField
    }()

    private let nicknameInValidTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "이미 존재하는 닉네임입니다."
        label.textColor = UIColor(red: 249/255, green: 71/255, blue: 71/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    private let nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(named: "Gray100")
        button.setTitle("다음", for: .normal)
        button.setTitleColor(UIColor(named: "White"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.isEnabled = false
        return button
    }()

    var disposeBag = DisposeBag()

    override func setLayout() {
        super.setLayout()

        self.view.addSubviews(self.setiondotImageView, self.mainLabel, self.textField, self.nicknameInValidTitleLabel,self.nextButton)
        NSLayoutConstraint.activate([

            self.setiondotImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 44),
            self.setiondotImageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.setiondotImageView.widthAnchor.constraint(equalToConstant: 44),
            self.setiondotImageView.heightAnchor.constraint(equalToConstant: 8),

            self.mainLabel.topAnchor.constraint(equalTo: self.setiondotImageView.bottomAnchor, constant: 32),
            self.mainLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),

            self.textField.topAnchor.constraint(equalTo: self.mainLabel.bottomAnchor, constant: 32),
            self.textField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.textField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.textField.heightAnchor.constraint(equalToConstant: 52),

            self.nicknameInValidTitleLabel.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 14),
            self.nicknameInValidTitleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

            self.nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            self.nextButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.nextButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.nextButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        self.nicknameInValidTitleLabel.isHidden = true
        self.textField.layer.borderColor = UIColor.white.cgColor

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150
    }

    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
}

extension OnboardingSecondViewController {
    func bind(reactor: OnboardingSecondReactor) {

        self.textField.rx.controlEvent([.allTouchEvents])
            .subscribe(onNext: {
                self.textField.becomeFirstResponder()
            })
            .disposed(by: self.disposeBag)

        self.textField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: {
                self.textField.resignFirstResponder()
            })
            .disposed(by: self.disposeBag)

        self.textField.rx.text.orEmpty.changed
            .subscribe(onNext: { text in
                self.trimNickname(text)
            })
            .disposed(by: disposeBag)

        self.textField.rx.text.orEmpty.changed
            .map { Reactor.Action.setNickname($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        self.nextButton.rx.tap
            .subscribe(onNext: {
                let onboardingThirdViewController = OnboardingThirdViewController()
                onboardingThirdViewController.reactor = OnboardingThirdReactor()
                self.navigationController?.pushViewController(onboardingThirdViewController, animated: false)
            })
            .disposed(by: self.disposeBag)

        reactor.state
            .map { 1 < $0.nickname?.count ?? 0 && $0.nickname?.count ?? 0 < 7 }
            .subscribe(onNext: { isEnabled in
                self.nextButton.isEnabled = isEnabled
                self.nextButton.backgroundColor = isEnabled ? UIColor(named: "Black") : UIColor(named: "Gray100")
            })
            .disposed(by: disposeBag)

        reactor.state
            .map { $0.isValideNickname }
            .subscribe(onNext: {
                if $0 == true {
                    self.nicknameInValidTitleLabel.isHidden = true
                    self.textField.layer.borderColor = UIColor.white.cgColor
                    self.textField.layer.borderWidth = 1
                } else {
                    self.nicknameInValidTitleLabel.isHidden = false
                    self.textField.layer.borderColor = UIColor(red: 249/255, green: 71/255, blue: 71/255, alpha: 1).cgColor
                    self.textField.layer.borderWidth = 1
                }
            })
            .disposed(by: disposeBag)

        reactor.state
            .map { $0.nickname }
            .subscribe(onNext: {
                self.textField.text = $0
            })
            .disposed(by: self.disposeBag)

    }

    private func trimNickname(_ nickname: String) {

        if nickname.count > 6 {
            let index = nickname.index(nickname.startIndex, offsetBy: 6)
            self.textField.text = String(nickname[..<index])
        }
    }
}
