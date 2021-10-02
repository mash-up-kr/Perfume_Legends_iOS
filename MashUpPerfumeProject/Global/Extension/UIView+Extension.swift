//
//  UIView+Extension.swift
//  MashUpPerfumeProject
//
//  Created by 선민승 on 2021/09/12.
//

import UIKit

extension UIView {
    func addSubview(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
    
    func addSubview(_ views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
}
