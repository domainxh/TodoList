//
//  HomeCell.swift
//  List
//
//  Created by Xiaoheng Pan on 9/7/19.
//  Copyright © 2019 Xiaoheng Pan. All rights reserved.
//

import UIKit

private let horizontalPadding = 12
private let verticalPadding = 12

class HomeCell: UITableViewCell {

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Place holder text"
        label.font = UIFont.homeListLabel
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.text = "9/10/19"
        label.font = UIFont.subtitleLabel
        return label
    }()

    private func setupView() {
        addSubviews(descriptionLabel, dateLabel)
        addConstraintsWithFormat("H:|-\(horizontalPadding)-[v0]-\(horizontalPadding)-|", views: descriptionLabel)
        addConstraintsWithFormat("H:|-\(horizontalPadding)-[v0]-\(horizontalPadding)-|", views: dateLabel)
        addConstraintsWithFormat("V:|-\(verticalPadding)-[v0]-[v1]-\(verticalPadding)-|", views: descriptionLabel, dateLabel)
    }

    func configureCell(listViewModel: ListViewModel, indexPath: IndexPath) {
        setupView()
        let list = listViewModel.todoLists[indexPath.row]
        let description = list.name
        let date = list.date

        dateLabel.text = date?.convertToString()
        descriptionLabel.text = description
    }
}

extension HomeCell {
    static var reuseIdentifier: String {
        return String(describing: HomeCell.self)
    }
}
