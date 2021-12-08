//
//  PerfumeDetailAccordsView.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/06.
//

import UIKit

final class PerfumeDetailAccordsView: UIView {
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "구성 성분"
        
        return label
    }()
    
    private let firstAccordView = AccordsView()
    private let secondAccordView = AccordsView()
    private let thirdAccordView = AccordsView()
    private let fourthAccordView = AccordsView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setLayout()
    }
    
    private func setLayout() {
        addSubviews(titleLabel, firstAccordView, secondAccordView, thirdAccordView, fourthAccordView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            firstAccordView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 34),
            firstAccordView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            firstAccordView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            secondAccordView.topAnchor.constraint(equalTo: firstAccordView.bottomAnchor, constant: -10),
            secondAccordView.leadingAnchor.constraint(equalTo: firstAccordView.leadingAnchor),
            secondAccordView.trailingAnchor.constraint(equalTo: firstAccordView.trailingAnchor),
            
            thirdAccordView.topAnchor.constraint(equalTo: secondAccordView.bottomAnchor, constant: -10),
            thirdAccordView.leadingAnchor.constraint(equalTo: firstAccordView.leadingAnchor),
            thirdAccordView.trailingAnchor.constraint(equalTo: firstAccordView.trailingAnchor),
            
            fourthAccordView.topAnchor.constraint(equalTo: thirdAccordView.bottomAnchor, constant: -10),
            fourthAccordView.leadingAnchor.constraint(equalTo: firstAccordView.leadingAnchor),
            fourthAccordView.trailingAnchor.constraint(equalTo: firstAccordView.trailingAnchor),
            fourthAccordView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
    }
    
    func setView(accords: [PerfumeDetail.Accord]) {
        firstAccordView.setView(accords: [accords[0]], font: .systemFont(ofSize: 18, weight: .bold), textColor: .black)
        secondAccordView.setView(accords: [accords[1]], font: .systemFont(ofSize: 14))
        thirdAccordView.setView(accords: [accords[2]], font: .systemFont(ofSize: 14))
        fourthAccordView.setView(accords: Array(accords[3...(accords.count - 1)]), font: .systemFont(ofSize: 14), isColor: false)
    }
}

extension PerfumeDetailAccordsView {
    final class AccordsView: UIView {
        private let topColorImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "Frame")?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            imageView.contentMode = .bottom
            
            return imageView
        }()
        
        private let middleColorView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            
            return view
        }()
        
        private let lineView: UIView = {
            let view = UIView()
            view.backgroundColor = .black
            
            return view
        }()
        
        private let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 3
            stackView.alignment = .top
            
            return stackView
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setLayout()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            
            setLayout()
        }
        
        private func setLayout() {
            addSubviews(topColorImageView, middleColorView, lineView, stackView)
            
            let stackViewBottomConstraint = stackView.bottomAnchor.constraint(equalTo: middleColorView.bottomAnchor, constant: -20)
            stackViewBottomConstraint.priority = .defaultHigh
            NSLayoutConstraint.activate([
                topColorImageView.topAnchor.constraint(equalTo: topAnchor),
                topColorImageView.heightAnchor.constraint(equalToConstant: 9),
                topColorImageView.widthAnchor.constraint(equalToConstant: 95),
                topColorImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                
                middleColorView.topAnchor.constraint(equalTo: topColorImageView.bottomAnchor),
                middleColorView.leadingAnchor.constraint(equalTo: topColorImageView.leadingAnchor),
                middleColorView.trailingAnchor.constraint(equalTo: topColorImageView.trailingAnchor),
                middleColorView.heightAnchor.constraint(greaterThanOrEqualToConstant: 61),
                middleColorView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                lineView.heightAnchor.constraint(equalToConstant: 0.5),
                lineView.widthAnchor.constraint(equalToConstant: 9),
                lineView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
                lineView.leadingAnchor.constraint(equalTo: topColorImageView.trailingAnchor, constant: 8),
                
                stackView.topAnchor.constraint(equalTo: lineView.topAnchor, constant: -10),
                stackView.leadingAnchor.constraint(equalTo: lineView.trailingAnchor, constant: 8),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                stackViewBottomConstraint
            ])
        }
        
        func setView(accords: [PerfumeDetail.Accord], font: UIFont, textColor: UIColor = .gray200, isColor: Bool = true) {
            accords.forEach {
                let label = UILabel()
                label.textColor = textColor
                label.font = font
                label.text = $0.name
                if isColor {
                    let color = hexStringToUIColor(hex: $0.backgroundColor)
                    topColorImageView.tintColor = color
                    middleColorView.backgroundColor = color
                }
                
                stackView.addArrangedSubviews(label)
            }
        }
        
        
        func hexStringToUIColor (hex:String) -> UIColor {
            var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

            if (cString.hasPrefix("#")) {
                cString.remove(at: cString.startIndex)
            }

            if ((cString.count) != 6) {
                return UIColor.gray
            }

            var rgbValue:UInt64 = 0
            Scanner(string: cString).scanHexInt64(&rgbValue)

            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
    }
}
