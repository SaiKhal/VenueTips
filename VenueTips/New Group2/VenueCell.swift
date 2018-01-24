//
//  VenueCell.swift
//  VenueTips
//
//  Created by C4Q on 1/22/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class VenueCell: UICollectionViewCell {
    
    lazy var venueImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "placeholder-image")
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    //TODO convenience init for custom cell based on zip code to setup aproppriate image and data
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupVenueImageView()
    }
    
    private func setupVenueImageView() {
        addSubview(venueImageView)
        venueImageView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        
    }
    
    
}
