//
//  UICollectionViewCell+Extension.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/13.
//

import UIKit

extension UICollectionViewCell: IdentifiableType {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
