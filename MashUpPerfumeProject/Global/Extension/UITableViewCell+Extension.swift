//
//  UITableViewCell+Extension.swift
//  MashUpPerfumeProject
//
//  Created by Hochan Lee on 2021/11/13.
//

import UIKit

protocol IdentifiableType {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: IdentifiableType {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
