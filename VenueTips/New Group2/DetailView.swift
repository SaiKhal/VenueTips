//
//  DetailView.swift
//  VenueTips
//
//  Created by Masai Young on 1/25/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit
import CoreLocation

class VenueDetailView: UIView {
    
    lazy var venueLabel: UILabel = {
        let label = UILabel()
        label.text = "Placeholder text"
        label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        label.backgroundColor = UIColor.lightGray
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var venueImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.white
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var directionButton: UIButton = {
        let bttn = UIButton()
        bttn.setTitle("Get Directions", for: .normal)
        bttn.backgroundColor = UIColor.orange
        //bttn.setTitleColor(UIColor.orange, for: .normal)
        return bttn
    }()
    
    lazy var tiplabel: UILabel = {
        let label = UILabel()
        label.text = "Leave a tip"
        label.font = UIFont.systemFont(ofSize: 20)
        label.backgroundColor = UIColor.lightGray
        label.textAlignment = .center
        return label
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
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupVenueLabel()
        setupVenueImageView()
        setupCategoryLabel()
        setupTipLabel()
    }
    
    
    func setupVenueLabel() {
        addSubview(venueLabel)
        venueLabel.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    
    func setupVenueImageView() {
        addSubview(venueImageView)
        venueImageView.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(venueLabel.snp.bottom).multipliedBy(1)
            make.width.equalTo(snp.width)
            make.height.equalTo(snp.height).multipliedBy(0.64)
        }
    }
    
    func setupCategoryLabel() {
        addSubview(directionButton)
        directionButton.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(venueImageView.snp.bottom)
            make.width.equalTo(snp.width)
            make.height.equalTo(snp.height).multipliedBy(0.07)
            make.centerX.equalTo(snp.centerX)
        }
    }
    
    func setupTipLabel() {
        addSubview(tiplabel)
        tiplabel.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(directionButton.snp.bottom)
            make.width.equalTo(snp.width)
            make.height.equalTo(snp.height).multipliedBy(0.07)
            make.centerX.equalTo(snp.centerX)
        }
    }
    
    
}


