//
//  OnboardingFourthViewController.swift
//  MashUpPerfumeProject
//
//  Created by 최원석 on 2021/10/24.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import Moya
import RxMoya

class OnboardingFourthViewController: BaseViewController, View {

//    private var age: BehaviorRelay<OnboardingThirdViewController.Gender>?
//    private var gender: BehaviorRelay<OnboardingThirdViewController.Age>?
    private let perfumeTypesModel = BehaviorRelay<[Int]>(value: [])

//    private var collectionViewModel = Observable.of([CollectionViewModel(image: UIImage(named: "citrus_yellow"), title: "CITRUS"), CollectionViewModel(image: UIImage(named: "fruits&vegetables _purple"), title: "FRUITS &\nVEGETABLE"), CollectionViewModel(image: UIImage(named: "flowers_pink"), title: "FLOWERS"), CollectionViewModel(image: UIImage(named: "whiteFlowers_skyblue"), title: "WHITE FLOWERS"), CollectionViewModel(image: UIImage(named: "greens_green"), title: "GREENS"), CollectionViewModel(image: UIImage(named: "spices_brown"), title: "SPICES"), CollectionViewModel(image: UIImage(named: "sweets&gourmand_pink"), title: "SWEETS &\nGOURMAND"), CollectionViewModel(image: UIImage(named: "woods_brown"), title: "WOODS"), CollectionViewModel(image: UIImage(named: "resins&balsams_brown"), title: "RESINS & BALSAMS"), CollectionViewModel(image: UIImage(named: "animalic_orange"), title: "ANIMALIC"), CollectionViewModel(image: UIImage(named: "beverages_red"), title: "BEVERAGES"), CollectionViewModel(image: UIImage(named: "natural&systhetic_blue"), title: "NATURAL &\nSYNTHETIC"), CollectionViewModel(image: UIImage(named: "uncategorized_black"), title: "UNCATEGORIZED")])

    let provider = MoyaProvider<APITarget>()

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

    private let setiondotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Sectin_dot_3")
        return imageView
    }()

    private let skipButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "skip"), for: .normal)
        button.setImage(UIImage(named: "skip"), for: .selected)
        return button
    }()

    private let mainLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "좋아하는\n향수 노트를 알고 싶어요."
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
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
        label.text = "취향을 선택하고 나에게 맞는 향수를 찾아주세요."
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        return label
    }()

    private let collectionViewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "최대 3가지 선택"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)
        return label
    }()

    private let nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(named: "Gray100")
        button.setTitle("선택 완료", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.isEnabled = false
        return button
    }()

    private var collectionView: ContentsizedCollectionView = {

        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumInteritemSpacing = 12
        flowlayout.minimumLineSpacing = 12
        flowlayout.sectionInset = UIEdgeInsets(top: 28, left: 20, bottom: 26, right: 20)

        let itemWidth = ((UIScreen.main.bounds.width - 52) / 2)
        flowlayout.itemSize = CGSize(width: itemWidth, height: 104)

        let collectionView = ContentsizedCollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: "OnboardingCollectionViewCell")

        return collectionView
    }()

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        //        self.navigationController?.isNavigationBarHidden = true
    }

    override func setLayout() {
        super.setLayout()

        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.baseView)
        self.baseView.addSubviews(self.setiondotImageView, self.skipButton, self.mainLabel, self.contentLabel, self.collectionViewLabel, self.collectionView, self.nextButton)

        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.baseView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),

            self.baseView.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor, constant: 0),
            self.baseView.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor, constant: 0),
            self.baseView.trailingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.trailingAnchor, constant: 0),
            self.baseView.bottomAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.bottomAnchor, constant: 0),
            self.baseView.widthAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.widthAnchor),
            self.baseView.heightAnchor.constraint(lessThanOrEqualToConstant: 2000),

            self.setiondotImageView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 44),
            self.setiondotImageView.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
            self.setiondotImageView.widthAnchor.constraint(equalToConstant: 44),
            self.setiondotImageView.heightAnchor.constraint(equalToConstant: 8),

            self.skipButton.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 84),
            self.skipButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),

            self.mainLabel.topAnchor.constraint(equalTo: self.setiondotImageView.bottomAnchor, constant: 32),
            self.mainLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),

            self.contentLabel.topAnchor.constraint(equalTo: self.mainLabel.bottomAnchor, constant: 12),
            self.contentLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),

            self.collectionViewLabel.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
            self.collectionViewLabel.topAnchor.constraint(equalTo: self.contentLabel.bottomAnchor, constant: 28),

            self.nextButton.bottomAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.bottomAnchor, constant: -6),
            self.nextButton.leadingAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
            self.nextButton.trailingAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.trailingAnchor, constant: -20),
            self.nextButton.heightAnchor.constraint(equalToConstant: 52),

            self.collectionView.topAnchor.constraint(equalTo: self.collectionViewLabel.bottomAnchor, constant: 0),
            self.collectionView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 0),
            self.collectionView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: 0),
            self.collectionView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -62)
        ])
    }
}

extension OnboardingFourthViewController {
    func bind(reactor: OnboardingFourthReactor) {

        reactor.action.onNext(.requestNote)

        reactor.state.compactMap { $0.noteGroups }
            .distinctUntilChanged()
            .bind(to: self.collectionView.rx.items(cellIdentifier: "OnboardingCollectionViewCell", cellType: OnboardingCollectionViewCell.self)) {
            index, element, cell in
            cell.configure(element)
        }.disposed(by: disposeBag)

        reactor.state
            .map { !($0.perfumeTypes?.isEmpty ?? true) }.compactMap { $0 }
            .subscribe(onNext: { isEnabled in
                self.nextButton.isEnabled = isEnabled
                self.nextButton.backgroundColor = isEnabled ? UIColor(named: "Black") : UIColor(named: "Gray100")
            })
            .disposed(by: self.disposeBag)

        self.collectionView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                var array = self.perfumeTypesModel.value
                array.append(indexPath.item)
                self.perfumeTypesModel.accept(array)
            })
            .disposed(by: self.disposeBag)

        self.collectionView.rx.itemDeselected
            .subscribe(onNext: { indexPath in
                var array = self.perfumeTypesModel.value
                if let index = array.firstIndex(of: indexPath.item) {
                    array.remove(at: index)
                    self.perfumeTypesModel.accept(array)
                }
            })
            .disposed(by: self.disposeBag)

        self.collectionView.rx.itemSelected
            .map { _ in
                Reactor.Action.selectPerfumeType(self.perfumeTypesModel.value)
            }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)

        self.collectionView.rx.itemDeselected
            .map { _ in
                Reactor.Action.selectPerfumeType(self.perfumeTypesModel.value)
            }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)

        self.nextButton.rx.tap
            .map { return Reactor.Action.setMemberInitialize(reactor.currentState.gender, reactor.currentState.age, reactor.currentState.perfumeTypes) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        self.skipButton.rx.tap
            .subscribe(onNext: {
                let viewController = ViewController()
                viewController.reactor = NewReactor()
                self.navigationController?.pushViewController(viewController, animated: false)
            })
            .disposed(by: self.disposeBag)

        self.nextButton.rx.tap
            .subscribe(onNext: {
                let viewController = ViewController()
                viewController.reactor = NewReactor()
                self.navigationController?.pushViewController(viewController, animated: false)
            })
            .disposed(by: self.disposeBag)

        reactor.state.map { $0.isLoading }
        .distinctUntilChanged()
        .bind(to: activityIndicator.rx.isAnimating)
        .disposed(by: disposeBag)
    }
}

extension OnboardingFourthViewController {

    struct CollectionViewModel {
        let image: UIImage?
        let title: String?
    }
}

extension OnboardingFourthViewController {

    enum PerfumeType: Int {
        case citrus
        case fruitsAndvegetables
        case flowers
        case whiteflowers
        case greens
        case spices
        case sweetsAndgourmand
        case woods
        case resinsAndbalsams
        case animalic
        case beverages
        case naturalAndsynthetic
    }
}
