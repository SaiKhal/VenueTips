//
//  VenueCellWithAdd.swift
//  VenueTips
//
//  Created by C4Q on 1/23/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

//class VenueCellWithAdd: UICollectionViewCell {
//
//}

class VenueCellWithAdd: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.backgroundColor = .cyan
        return img
    }()
        lazy var addButton: UIButton = {
           let butt = UIButton()
            butt.setTitle("+", for: .normal)
            butt.setTitleColor(.blue, for: .normal)
           
            return butt
        }()
    lazy var textLabel: UILabel = {
        let lab = UILabel()
        return lab
    }()
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        setupViews()
    }
    private func setupViews() {
        setupImageView()
        setupButton()
        setupLabel()
    }
    private func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8).isActive = true
    }
    private func setupLabel() {
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    private func setupButton() {
        addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        addButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
    }
}
