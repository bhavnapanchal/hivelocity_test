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
                idLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
                idLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
                titleLabel.topAnchor.constraint(equalTo: idLabel.topAnchor),
                titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
                titleLabel.rightAnchor.constraint(equalTo: idLabel.rightAnchor),
                completedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
                completedLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
                completedLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
                completedLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
            ]
        )

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
