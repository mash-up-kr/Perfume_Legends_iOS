//
//  OnboardingThirdViewController.swift
//  MashUpPerfumeProject
//
//  Created by 최원석 on 2021/10/21.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import Moya
import RxMoya

class OnboardingThirdViewController: BaseViewController, View {

    let provider = MoyaProvider<APITarget>()

    private let setiondotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Sectin_dot_2")
        return imageView
    }()

    private let mainLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "성별과\n나이를 선택해주세요."
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        let attrString = NSMutableAttributedString(string: label.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        label.attributedText = attrString
        return label
    }()

    private let skipButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "skip"), for: .normal)
        button.setImage(UIImage(named: "skip"), for: .selected)
        return button
    }()

    private let genderTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "성별"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private let ageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "나이"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private let femaleButton: SeletableButton = {
        let button = SeletableButton()
        button.setImage(UIImage(named: "ic_gender_woman_white_disabled_157"), for: .normal)
        button.setImage(UIImage(named: "ic_gender_woman_white_inabled_157"), for: .selected)
        button.adjustsImageWhenHighlighted = false
        button.normalTintColor = .white
        button.selectTintColor = .white
        button.normalBackgroundColor = .clear
        button.selectBackgroundColor = .clear
        button.normalBorderColor = .clear
        button.selectBorderColor = .clear
        return button
    }()

    private let maleButton: SeletableButton = {
        let button = SeletableButton()
        button.setImage(UIImage(named: "ic_gender_man_white_disabled_157"), for: .normal)
        button.setImage(UIImage(named: "ic_gender_man_white_inabled_157"), for: .selected)
        button.adjustsImageWhenHighlighted = false
        button.normalTintColor = .white
        button.selectTintColor = .white
        button.normalBackgroundColor = .clear
        button.selectBackgroundColor = .clear
        button.normalBorderColor = .clear
        button.selectBorderColor = .clear
        return button
    }()

    private let teenagerButton: SeletableButton = {
        let button = SeletableButton.init(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.cornerRadius = 0.5 * button.bounds.size.width
        button.setTitle("10대", for: .normal)
        button.setTitleColor(UIColor(named: "Gray100"), for: .normal)
        button.setTitleColor(UIColor(named: "Black"), for: .selected)
        button.normalTintColor = .white
        button.selectTintColor = .white
        button.normalBackgroundColor = .white
        button.selectBackgroundColor = .white
        button.normalBorderColor = .white
        button.selectBorderColor = UIColor(named: "Skyblue")
        return button
    }()

    private let twentiesButton: SeletableButton = {
        let button = SeletableButton.init(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.cornerRadius = 0.5 * button.bounds.size.width
        button.setTitle("20대", for: .normal)
        button.setTitleColor(UIColor(named: "Gray100"), for: .normal)
        button.setTitleColor(UIColor(named: "Black"), for: .selected)
        button.normalTintColor = .white
        button.selectTintColor = .white
        button.normalBackgroundColor = .white
        button.selectBackgroundColor = .white
        button.normalBorderColor = .white
        button.selectBorderColor = UIColor(named: "Skyblue")
        return button
    }()

    private let thirtiesButton: SeletableButton = {
        let button = SeletableButton.init(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.cornerRadius = 0.5 * button.bounds.size.width
        button.setTitle("30대", for: .normal)
        button.setTitleColor(UIColor(named: "Gray100"), for: .normal)
        button.setTitleColor(UIColor(named: "Black"), for: .selected)
        button.normalTintColor = .white
        button.selectTintColor = .white
        button.normalBackgroundColor = .white
        button.selectBackgroundColor = .white
        button.normalBorderColor = .white
        button.selectBorderColor = UIColor(named: "Skyblue")
        return button
    }()

    private let fouriesButton: SeletableButton = {
        let button = SeletableButton.init(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.cornerRadius = 0.5 * button.bounds.size.width
        button.setTitle("40대", for: .normal)
        button.setTitleColor(UIColor(named: "Gray100"), for: .normal)
        button.setTitleColor(UIColor(named: "Black"), for: .selected)
        button.normalTintColor = .white
        button.selectTintColor = .white
        button.normalBackgroundColor = .white
        button.selectBackgroundColor = .white
        button.normalBorderColor = .white
        button.selectBorderColor = UIColor(named: "Skyblue")
        return button
    }()

    private let fiftiesButton: SeletableButton = {
        let button = SeletableButton.init(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.cornerRadius = 0.5 * button.bounds.size.width
        button.setTitle("50대", for: .normal)
        button.setTitleColor(UIColor(named: "Gray100"), for: .normal)
        button.setTitleColor(UIColor(named: "Black"), for: .selected)
        button.normalTintColor = .white
        button.selectTintColor = .white
        button.normalBackgroundColor = .white
        button.selectBackgroundColor = .white
        button.normalBorderColor = .white
        button.selectBorderColor = UIColor(named: "Skyblue")
        return button
    }()

    private let nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(named: "Gray100")
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.isEnabled = false
        return button
    }()

    private lazy var genderButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.femaleButton, self.maleButton])
        stackView.axis = .horizontal
        stackView.spacing = 21
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var ageButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.teenagerButton, self.twentiesButton, self.thirtiesButton, self.fouriesButton, self.fiftiesButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()

    var disposeBag = DisposeBag()

    override func setLayout() {
        super.setLayout()

        self.view.addSubviews(self.setiondotImageView, self.skipButton, self.mainLabel, self.genderTitleLabel, self.genderButtonStackView, self.ageTitleLabel, self.ageButtonStackView, self.nextButton)

        NSLayoutConstraint.activate([
            self.setiondotImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 44),
            self.setiondotImageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.setiondotImageView.widthAnchor.constraint(equalToConstant: 44),
            self.setiondotImageView.heightAnchor.constraint(equalToConstant: 8),

            self.skipButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 84),
            self.skipButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),

            self.mainLabel.topAnchor.constraint(equalTo: self.setiondotImageView.bottomAnchor, constant: 32),
            self.mainLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),

            self.genderTitleLabel.topAnchor.constraint(equalTo: self.mainLabel.bottomAnchor, constant: 44),
            self.genderTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),

            self.genderButtonStackView.topAnchor.constraint(equalTo: self.genderTitleLabel.bottomAnchor, constant: 0),
            self.genderButtonStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.genderButtonStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.genderButtonStackView.heightAnchor.constraint(equalToConstant: (self.view.frame.width - 61)/2),

            self.ageTitleLabel.topAnchor.constraint(equalTo: self.genderButtonStackView.bottomAnchor, constant: 36),
            self.ageTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),

            self.ageButtonStackView.topAnchor.constraint(equalTo: self.ageTitleLabel.bottomAnchor, constant: 28),
            self.ageButtonStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.ageButtonStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.ageButtonStackView.heightAnchor.constraint(equalToConstant: (self.view.frame.width - 72)/5),

            self.nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            self.nextButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.nextButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
    }
}

extension OnboardingThirdViewController {
    func bind(reactor: OnboardingThirdReactor) {

        self.femaleButton.rx.tap
            .map { Reactor.Action.selectGender(self.femaleButton.isSelected ? nil : .female) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)

        self.maleButton.rx.tap
            .map { Reactor.Action.selectGender(self.maleButton.isSelected ? nil : .male) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)

        self.teenagerButton.rx.tap
            .map { Reactor.Action.selectAge(self.teenagerButton.isSelected ? nil : .teenager) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)

        self.twentiesButton.rx.tap
            .map { Reactor.Action.selectAge(self.twentiesButton.isSelected ? nil : .twenties) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)

        self.thirtiesButton.rx.tap
            .map { Reactor.Action.selectAge(self.thirtiesButton.isSelected ? nil : .thirties) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)

        self.fouriesButton.rx.tap
            .map { Reactor.Action.selectAge(self.fouriesButton.isSelected ? nil : .fouries) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)

        self.fiftiesButton.rx.tap
            .map { Reactor.Action.selectAge(self.fiftiesButton.isSelected ? nil : .fifties) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)

        self.femaleButton.rx.tap
            .subscribe(onNext: {
                self.femaleButton.isSelected = !self.femaleButton.isSelected
                self.maleButton.isSelected = false
            })
            .disposed(by: self.disposeBag)

        self.maleButton.rx.tap
            .subscribe(onNext: {
                self.maleButton.isSelected = !self.maleButton.isSelected
                self.femaleButton.isSelected = false
            })
            .disposed(by: self.disposeBag)

        self.teenagerButton.rx.tap
            .subscribe(onNext: {
                self.teenagerButton.isSelected = !self.teenagerButton.isSelected
                self.deselectedButtons(seletedButton: self.teenagerButton, buttons: [self.teenagerButton, self.twentiesButton, self.thirtiesButton, self.fouriesButton, self.fiftiesButton])
            })
            .disposed(by: self.disposeBag)

        self.twentiesButton.rx.tap
            .subscribe(onNext: {
                self.twentiesButton.isSelected = !self.twentiesButton.isSelected
                self.deselectedButtons(seletedButton: self.twentiesButton, buttons: [self.teenagerButton, self.twentiesButton, self.thirtiesButton, self.fouriesButton, self.fiftiesButton])
            })
            .disposed(by: self.disposeBag)

        self.thirtiesButton.rx.tap
            .subscribe(onNext: {
                self.thirtiesButton.isSelected = !self.thirtiesButton.isSelected
                self.deselectedButtons(seletedButton: self.thirtiesButton, buttons: [self.teenagerButton, self.twentiesButton, self.thirtiesButton, self.fouriesButton, self.fiftiesButton])
            })
            .disposed(by: self.disposeBag)

        self.fouriesButton.rx.tap
            .subscribe(onNext: {
                self.fouriesButton.isSelected = !self.fouriesButton.isSelected
                self.deselectedButtons(seletedButton: self.fouriesButton, buttons: [self.teenagerButton, self.twentiesButton, self.thirtiesButton, self.fouriesButton, self.fiftiesButton])
            })
            .disposed(by: self.disposeBag)

        self.fiftiesButton.rx.tap
            .subscribe(onNext: {
                self.fiftiesButton.isSelected = !self.fiftiesButton.isSelected
                self.deselectedButtons(seletedButton: self.fiftiesButton, buttons: [self.teenagerButton, self.twentiesButton, self.thirtiesButton, self.fouriesButton, self.fiftiesButton])
            })
            .disposed(by: self.disposeBag)

        self.nextButton.rx.tap
            .subscribe(onNext: {
                let onboardingFourthViewController = OnboardingFourthViewController()
                onboardingFourthViewController.reactor = OnboardingFourthReactor(gender: reactor.currentState.gender?.rawValue, age: reactor.currentState.age?.rawValue)
                self.navigationController?.pushViewController(onboardingFourthViewController, animated: false)
            })
            .disposed(by: self.disposeBag)

        self.skipButton.rx.tap
            .subscribe(onNext: {
                let onboardingFourthViewController = OnboardingFourthViewController()
                onboardingFourthViewController.reactor = OnboardingFourthReactor(gender: nil, age: nil)
                self.navigationController?.pushViewController(onboardingFourthViewController, animated: false)
            })
            .disposed(by: self.disposeBag)

        reactor.state
            .map { $0.gender != nil && $0.age != nil }
            .subscribe(onNext: { isEnabled in
                self.nextButton.isEnabled = isEnabled
                self.nextButton.backgroundColor = isEnabled ? UIColor(named: "Black") : UIColor(named: "Gray100")
            })
            .disposed(by: self.disposeBag)
    }

    private func deselectedButtons(seletedButton: UIButton ,buttons: [UIButton]) {
        buttons.filter { $0 != seletedButton }.forEach { $0.isSelected = false }
    }
}

extension OnboardingThirdViewController {

    enum Gender: String {
        case male = "남성"
        case female = "여성"
    }

    enum Age: String {
        case teenager = "10대"
        case twenties = "20대"
        case thirties = "30대"
        case fouries = "40대"
        case fifties = "50대"
    }
}
