//
//  File.swift
//  VenueTips
//
//  Created by Masai Young on 1/16/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

class CreationView: UIView {
    
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
    
    lazy var dismissVCButton: UIButton = {
        let bttn = UIButton()
        bttn.backgroundColor = .orange
        return bttn
    }()
    
    lazy var titleLabel: UILabel = {
        let iv = UILabel()
        iv.text = "Add or Create Collections"
        return iv
    }()
    
    lazy var creationButton: UIButton = {
        let bttn = UIButton()
        bttn.setTitle("CREATE", for: .normal)
        bttn.setTitleColor(.orange, for: .normal)
        return bttn
    }()
    
    lazy var titleField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .blue
        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 10
        return tf
    }()
    
    lazy var tipField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .blue
        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 10
        return tf
    }()
    
    lazy var largeField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .blue
        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 10
        return tf
    }()
    
    func setupViews() {
        setHeaderStackView()
        setTitleField()
        setTipField()
        setLargeField()
    }
    
    func setHeaderStackView() {
        self.addSubview(headerStackView)
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        headerStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        headerStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

    }
    
    func setTitleField() {
        self.addSubview(titleField)
        titleField.translatesAutoresizingMaskIntoConstraints = false
        titleField.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 20).isActive = true
        titleField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        titleField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        titleField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    func setTipField() {
        self.addSubview(tipField)
        tipField.translatesAutoresizingMaskIntoConstraints = false
        tipField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 20).isActive = true
        tipField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        tipField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        tipField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2).isActive = true

    }
    
    func setLargeField() {
        self.addSubview(largeField)
        largeField.translatesAutoresizingMaskIntoConstraints = false
        largeField.topAnchor.constraint(equalTo: tipField.bottomAnchor, constant: 20).isActive = true
        largeField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        largeField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        largeField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true

    }
    
    
}
