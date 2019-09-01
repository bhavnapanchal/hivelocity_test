//
//  TodoCell.swift
//  hivelocity-ios-test
//
//  Created by takanobu sugiyama on 2019/08/05.
//

import UIKit

class TodoCell: UITableViewCell {

    var data: (id: String, title: String, completed: Bool) = ("", "", false) {
        didSet {
            idLabel.text = data.id
            titleLabel.text = data.title
            if data.completed {
                completedLabel.textColor = UIColor(hue: 0.6, saturation: 0.8, brightness: 0.8, alpha: 1)
                completedLabel.text = "🤗 done"
            } else {
                completedLabel.textColor = UIColor(hue: 0, saturation: 0.6, brightness: 1, alpha: 1)
                completedLabel.text = "😞 not done"
            }
        }
    }

    private let idLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = UIColor(white: 0.9, alpha: 1)
        label.textAlignment = .right
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private let completedLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(idLabel)
        addSubview(titleLabel)
        addSubview(completedLabel)

        NSLayoutConstraint.activate(
            [
                /// ISSUE:(TEXT OVERLAPPING) You need to set "lessThanOrEqualTo" idLabel's leading anchor rather than idLabel's rightanchor
                /// So titleLabel's width will increase to leading point of idLable or less than that and it will not overlap text.
                
                /// SUGGESTION: You should always use leading and trailing anchors instead of left or right, so it wll automatically flip when app is running right to left locale.

                idLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
                idLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                titleLabel.topAnchor.constraint(equalTo: idLabel.topAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: idLabel.leadingAnchor),
                completedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
                completedLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                completedLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
                completedLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
            ]
        )

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
