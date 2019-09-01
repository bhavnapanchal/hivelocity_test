//
//  TodoViewController.swift
//  hivelocity-ios-test
//
//  Created by takanobu sugiyama on 2019/08/06.
//

import UIKit

class TodoViewController: UIViewController {


    let tapMeView = TapMe()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(tapMeView)
        tapMeView.centerInSuperview()

        tapMeView.onTap = {
            self.dismiss(animated: true)
        }


        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.text = "Tap Me To Close"
        label.textColor = .gray
        label.centerXAnchor.constraint(equalTo: tapMeView.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: tapMeView.bottomAnchor, constant: 10).isActive = true
    }

}
