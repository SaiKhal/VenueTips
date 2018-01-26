//
//  OtherCollectionView.swift
//  VenueTips
//
//  Created by Masai Young on 1/26/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

class OtherCollectionView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //        layout.sectionInset = UIEdgeInsets(top: 120, left: 20, bottom: 20, right: 20)
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.register(VenueCellWithAdd.self, forCellWithReuseIdentifier: "venueCellWithAdd")
        return cv
    }()
    
    private func commonInit() {
        backgroundColor = .red
        setupViews()
    }
    
    private func setupViews() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.addSubview(collectionView)
        self.collectionView.snp.remakeConstraints {(make) in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.trailing.equalTo(self.snp.trailing)
            make.leading.equalTo(self.snp.leading)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(self.snp.height)
        }
    }
    
    
}
