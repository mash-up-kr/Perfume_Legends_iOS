//
//  SignInViewController.swift
//  MashUpPerfumeProject
//
//  Created by 최원석 on 2021/11/17.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import Moya
import RxMoya

class SignInViewController: BaseViewController, View {
    let provider = MoyaProvider<APITarget>()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "테스트 라벨입니다."
        return label
    }()

    var disposeBag = DisposeBag()

    override func setLayout() {
        super.setLayout()

        self.view.addSubviews(self.titleLabel)

        NSLayoutConstraint.activate([

            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}

extension SignInViewController {
    func bind(reactor: SignInReactor) {

        reactor.action.onNext(.requestAccessToken(reactor.currentState.accessToken))

        reactor.state
            .map { $0.accessTokenExistence }
            .distinctUntilChanged()
            .subscribe(onNext: {
                if $0 == true {
                    reactor.action.onNext(.requestMemberInfo)
                } else {
                    reactor.action.onNext(.postLogInInfo(reactor.currentState.idProviderType, reactor.currentState.idProviderUserId))
                }
            })
            .disposed(by: self.disposeBag)

        reactor.state
            .map { $0.accessToken }
            .distinctUntilChanged()
            .subscribe(onNext: {
                UserDefaults.standard.set($0, forKey: "accesstoken")

                let onboardingFirstViewController = OnboardingFirstViewController()
                onboardingFirstViewController.reactor = OnboardingReactor()
                self.navigationController?.pushViewController(onboardingFirstViewController, animated: false)
            })
            .disposed(by: self.disposeBag)

        reactor.state
            .map { $0.memberInfo?.status }
            .distinctUntilChanged()
            .subscribe(onNext: {
                if $0 == "ACTIVE" {
                    let viewController = ViewController()
                    viewController.reactor = NewReactor()
                    self.navigationController?.pushViewController(viewController, animated: false)
                } else {
                    let onboardingFirstViewController = OnboardingFirstViewController()
                    onboardingFirstViewController.reactor = OnboardingReactor()
                    self.navigationController?.pushViewController(onboardingFirstViewController, animated: false)
                }
            })
    }
}
