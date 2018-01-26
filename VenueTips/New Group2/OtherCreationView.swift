//
//  OtherCreationView.swift
//  VenueTips
//
//  Created by C4Q on 1/23/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

class OtherCreationView: UIView {

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    lazy var dismissVCButton: UIButton = {
        let bttn = UIButton()
        bttn.setTitle("Cancel", for: .normal)
        //bttn.backgroundColor = .white
        bttn.setTitleColor(.orange, for: .normal)
        return bttn
    }()
    lazy var creationButton: UIButton = {
        let bttn = UIButton()
        bttn.setTitle("Create", for: .normal)
        bttn.setTitleColor(.orange, for: .normal)
        return bttn
    }()
    lazy var titleLabel: UILabel = {
        let iv = UILabel()
        iv.text = "Add or Create Collections"
        return iv
    }()
    lazy var tipLabel: UILabel = {
        let lab = UILabel()
        lab.text = "Leave a tip"
        lab.textAlignment = .center
        return lab
    }()
    lazy var textField: UITextField = {
        let tf = UITextField()
        //tf.backgroundColor = .blue
        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 10
        tf.placeholder = "enter a new collection title"
        return tf
    }()
    lazy var textView: UITextView = {
        let tv = UITextView()
        // tv.text = ""
        tv.layer.cornerRadius = 10
        tv.layer.borderWidth = 2
        tv.layer.borderColor = UIColor.lightGray.cgColor
        return tv
    }()
    lazy var headerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 15
        
        stack.addArrangedSubview(dismissVCButton)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(creationButton)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var customView = OtherCollectionView()
    
    private func setupViews() {
        setHeaderStackView()
        setTextField()
        setupTipLabel()
        setupTextView()
        setupCollectionView()
    }
    func setTextField() {
        self.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 15).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
    func setHeaderStackView() {
        self.addSubview(headerStackView)
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        headerStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        headerStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    private func setupTipLabel() {
        addSubview(tipLabel)
        tipLabel.translatesAutoresizingMaskIntoConstraints = false
        tipLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15).isActive = true
        tipLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
        tipLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
        tipLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    private func setupTextView() {
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: tipLabel.bottomAnchor, constant: 15).isActive = true
        textView.leadingAnchor.constraint(equalTo: tipLabel.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: tipLabel.trailingAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    private func setupCollectionView() {
        addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10).isActive = true
        customView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        customView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        customView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
    }

}
