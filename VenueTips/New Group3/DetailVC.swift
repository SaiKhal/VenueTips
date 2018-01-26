//
//  DetailVC.swift
//  VenueTips
//
//  Created by Masai Young on 1/25/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit
import CoreLocation

class VenueDetailVC: UIViewController {
    
    private var venue: Venue!
    private var photo: UIImage!
    
    let detailView = VenueDetailView()
    
    init(venue: Venue?, photo: UIImage?) {
        self.venue = venue
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not using coder!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setDetailView()
        detailView.venueImageView.image = photo
        detailView.venueLabel.text = venue.name
    }
    
    func setupNavBar() {
        let addBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToCollection))
        navigationItem.rightBarButtonItem = addBarItem
    }
    
    func setDetailView() {
        view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        detailView.directionButton.addTarget(self, action: #selector(showDirections), for: .touchUpInside)
    }
    
    @objc private func showDirections() {
        
        let userCoordinate = CLLocationCoordinate2DMake(UserDefaultsHelper.manager.getLatitude(), UserDefaultsHelper.manager.getLongitude())
        let placeCoordinate = CLLocationCoordinate2DMake(venue.location.lat, venue.location.lng)
        
        let directionsURLString = "http://maps.apple.com/?saddr=\(userCoordinate.latitude),\(userCoordinate.longitude)&daddr=\(placeCoordinate.latitude),\(placeCoordinate.longitude)"
        
        UIApplication.shared.open(URL(string: directionsURLString)!, options: [:]) { (done) in
            print("launched apple maps")
        }
    }
    
    @objc func addToCollection() {
        let tipCreationVC = TipCreationVC(venue: venue, image: photo)
        tipCreationVC.modalTransitionStyle = .crossDissolve
        tipCreationVC.modalPresentationStyle = .currentContext
        present(tipCreationVC, animated: true, completion: nil)
    }
    
    
}


