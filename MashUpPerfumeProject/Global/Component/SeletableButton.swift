//
//  SeletableButton.swift
//  MashUpPerfumeProject
//
//  Created by 최원석 on 2021/10/23.
//

import UIKit

class SeletableButton: UIButton {

    //    var normalBackgroundColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
    //        didSet {
    //            update()
    //        }
    //    }

    var normalBackgroundColor: UIColor? {
        didSet {
            update()
        }
    }

    var selectBackgroundColor: UIColor? {
        didSet {
            update()
        }
    }

    var normalBorderColor: UIColor? {
        didSet {
            update()
        }
    }

    var selectBorderColor: UIColor? {
        didSet {
            update()
        }
    }

    var normalTintColor: UIColor? {
        didSet {
            update()
        }
    }

    var selectTintColor: UIColor? {
        didSet {
            update()
        }
    }

    var cornerRadius: CGFloat = 8.0 {
        didSet {
            update()
        }
    }

    var borderWidth: CGFloat = 0.5 {
        didSet {
            update()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        update()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        update()
    }

    override var isSelected: Bool {
        didSet {
            update()
        }
    }

    private func update() {
        layer.cornerRadius = cornerRadius
        backgroundColor = isSelected ? selectBackgroundColor : normalBackgroundColor
        tintColor = isSelected ? selectTintColor : normalTintColor
        layer.borderWidth = borderWidth
        layer.borderColor = isSelected ? selectBorderColor?.cgColor : normalBorderColor?.cgColor
    }
}

