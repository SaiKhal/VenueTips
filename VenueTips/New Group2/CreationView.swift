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
    
    lazy var textField: UITextField = {
        let tf = UITextField()
        //tf.backgroundColor = .blue
        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 10
        tf.placeholder = "enter a new collection title"
        return tf
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
    private func setupViews() {
        setHeaderStackView()
        setTextField()
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
    
}

