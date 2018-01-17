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
    
    lazy var searchBar: MainCustomSearchBar = {
        let sb = MainCustomSearchBar()
        sb.backgroundColor = .white
        sb.searchBarStyle = .minimal
        return sb
    }()
    
    func setupViews() {
        setHeaderStackView()
        setSearchBar()
    }
    
    func setHeaderStackView() {
        self.addSubview(headerStackView)
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        headerStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        headerStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

    }
    
    func setSearchBar() {
        self.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        searchBar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
    }
    
    
}
