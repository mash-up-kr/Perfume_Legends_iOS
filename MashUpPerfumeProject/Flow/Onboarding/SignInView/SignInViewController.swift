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

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SignInImage")
        return imageView
    }()

    var disposeBag = DisposeBag()

    override func setLayout() {
        super.setLayout()

        self.view.addSubviews(self.imageView)

        NSLayoutConstraint.activate([

            self.imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
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

//                    let onboardingFirstViewController = OnboardingFirstViewController()
//                    onboardingFirstViewController.reactor = OnboardingReactor()
//                    self.navigationController?.pushViewController(onboardingFirstViewController, animated: false)
                } else {
                    let onboardingFirstViewController = OnboardingFirstViewController()
                    onboardingFirstViewController.reactor = OnboardingReactor()
                    self.navigationController?.pushViewController(onboardingFirstViewController, animated: false)
                }
            })

        reactor.state
            .map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: self.disposeBag)
    }
}
