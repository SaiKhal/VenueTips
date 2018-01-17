//
//  SearchView.swift
//  VenueTips
//
//  Created by Masai Young on 1/16/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

class SearchView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .purple
        setupViews()
    }
    
    lazy var searchBar: MainCustomSearchBar = {
        let sb = MainCustomSearchBar()
        sb.backgroundColor = .white
        sb.searchBarStyle = .minimal
        return sb
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "SearchCell")
        return cv
    }()
    
    func setSearchBar() {
        self.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
    
    func setCollectionView() {
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 30).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    func setupViews() {
        setSearchBar()
        setCollectionView()
    }
}
