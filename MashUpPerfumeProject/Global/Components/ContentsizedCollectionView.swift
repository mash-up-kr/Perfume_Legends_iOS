//
//  ContentsizedCollectionView.swift
//  MashUpPerfumeProject
//
//  Created by 최원석 on 2021/10/29.
//

import UIKit

final class ContentsizedCollectionView: UICollectionView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
