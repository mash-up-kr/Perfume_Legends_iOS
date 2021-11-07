//
//  OnboardingViewController.swift
//  MashUpPerfumeProject
//
//  Created by 최원석 on 2021/10/17.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import Moya
import RxMoya


class OnboardingFirstViewController: BaseViewController, View {
    let provider = MoyaProvider<APITarget>()

    private let onboardingBackgroundImageVIew: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "OnbardingBackground")
        return imageView
    }()

    private let diggingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image_logo_skyblue_37")
        return imageView
    }()

    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "나를 채워가는\n향수를 발견하다"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        let attrString = NSMutableAttributedString(string: label.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        label.attributedText = attrString
        return label
    }()

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "향수 노트로 향수 찾기를 시작하세요.\nLet's Start digging!"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        let attrString = NSMutableAttributedString(string: label.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        label.attributedText = attrString
        return label
    }()

    private let nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(named: "Black")
        button.setTitle("다음", for: .normal)
        button.setTitleColor(UIColor(named: "White"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return button
    }()

    var disposeBag = DisposeBag()

    override func setLayout() {
        super.setLayout()

        self.view.addSubviews(self.nextButton, self.mainTitleLabel, self.contentLabel, self.diggingImageView, self.onboardingBackgroundImageVIew)

        NSLayoutConstraint.activate([

            self.onboardingBackgroundImageVIew.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.onboardingBackgroundImageVIew.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.onboardingBackgroundImageVIew.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.onboardingBackgroundImageVIew.heightAnchor.constraint(equalToConstant: 215),

            self.diggingImageView.leadingAnchor.constraint(equalTo: self.onboardingBackgroundImageVIew.leadingAnchor, constant: 20),
            self.diggingImageView.bottomAnchor.constraint(equalTo: self.onboardingBackgroundImageVIew.bottomAnchor, constant: -16),
            self.diggingImageView.widthAnchor.constraint(equalToConstant: 85),
            self.diggingImageView.heightAnchor.constraint(equalToConstant: 27),

            self.mainTitleLabel.topAnchor.constraint(equalTo: self.onboardingBackgroundImageVIew.bottomAnchor, constant: 14),
            self.mainTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),

            self.contentLabel.topAnchor.constraint(equalTo: self.mainTitleLabel.bottomAnchor, constant: 20),
            self.contentLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),

            self.nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            self.nextButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.nextButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
}

extension OnboardingFirstViewController {
    func bind(reactor: OnboardingReactor) {

        self.nextButton.rx.tap
            .subscribe(onNext: {
                let onboardingSecondViewController = OnboardingSecondViewController()
                onboardingSecondViewController.reactor = OnboardingSecondReactor()
                self.navigationController?.pushViewController(onboardingSecondViewController, animated: false)
            })
            .disposed(by: self.disposeBag)
    }
}
