//
//  FooterView.swift
//  List
//
//  Created by Xiaoheng Pan on 9/10/19.
//  Copyright © 2019 Xiaoheng Pan. All rights reserved.
//

import UIKit

class FooterView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let footerLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("FooterView.EmptyDescription", comment: "")
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.homeListLabel
        return label
    }()

    private func setupUI() {
        addSubview(footerLabel)
        addConstraintsWithFormat("H:|-[v0]-|", views: footerLabel)
        addConstraintsWithFormat("V:|-[v0]-|", views: footerLabel)
    }
}

