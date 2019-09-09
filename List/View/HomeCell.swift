//
//  HomeCell.swift
//  List
//
//  Created by Xiaoheng Pan on 9/7/19.
//  Copyright © 2019 Xiaoheng Pan. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    private let horizontalPadding = 12
    private let verticalPadding = 12

    private let label: UILabel = {
        let label = UILabel()
        label.text = "Place holder text"
        label.font = UIFont.homeListLabel
        return label
    }()

    private func setupView() {
        addSubview(label)
        addConstraintsWithFormat("H:|-\(horizontalPadding)-[v0]|", views: label)
        addConstraintsWithFormat("V:|-\(verticalPadding)-[v0]-\(verticalPadding)-|", views: label)
    }

    func configureCell(listModel: ListModel) {
        setupView()
        label.text = listModel.name
    }
}

extension HomeCell {
    static var reuseIdentifier: String {
        return String(describing: HomeCell.self)
    }
}
