//
//  TapMe.swift
//  hivelocity-ios-test
//
//  Created by takanobu sugiyama on 2019/08/05.
//

import UIKit

class TapMe: UIView {

    var onTap: () -> Void = {}

    override init(frame: CGRect) {
        super.init(frame: frame)

        let button = UIButton(type: .roundedRect)
        button.setTitle("🐶", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 120)
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)

        addSubview(button)
        button.fitToSuperview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func buttonDidTap() {
        onTap()
    }

}
