//
//  SearchVC.swift
//  VenueTips
//
//  Created by Masai Young on 1/16/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

struct VenueWithImages {
    let venue: Venue
    let imageURL: String
}

class SearchVC: UIViewController {
    
    var venuesWithImages = [VenueWithImages]()
    
    let searchView = SearchView()
    var searchResults: VenueSearchResults? {
        didSet {
            var imageURL = ""
            let completionForPhotos: (VenuePhotoResults) -> Void = { (results) in
                guard let photo = results.response.photos.items.first else { return }
                let photoURL = "\(photo.purplePrefix)original\(photo.suffix)"
                imageURL = photoURL
            }
            
            searchResults?.response.venues?.forEach({ (venue) in
                let photoEndpoint = VenuePhotoAPIClient.manager.photoEndpoint(venue: venue)
                
                VenuePhotoAPIClient.manager.getVenuePhotos(from: photoEndpoint,
                                                           completionHandler: completionForPhotos,
                                                           errorHandler: handle)
                
                let venueWithImage = VenueWithImages(venue: venue, imageURL: imageURL)
                venuesWithImages.append(venueWithImage)
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setContentView()
        setNavBar()
    }
    
    lazy var completion: (VenueSearchResults) -> Void = { (result) in
        switch result.meta.code {
        // SUCCESS
        case 200:
            self.searchResults = result
            self.searchView.collectionView.reloadData()
            print("App should be running successfully.")
        //FAILURE - Handles errors returned from Foursquare API
        case 400:
            self.searchView.mapView.dodo.error("\(result.meta.errorDetail ?? "No given error.")")
            self.searchView.mapView.dodo.style.bar.hideAfterDelaySeconds = 3
        case 500:
            self.searchView.mapView.dodo.error("\(result.meta.errorDetail ?? "No given error.")")
            self.searchView.mapView.dodo.style.bar.hideAfterDelaySeconds = 3
        default:
            self.searchView.mapView.dodo.error("Random Error 😒")
            self.searchView.mapView.dodo.style.bar.hideAfterDelaySeconds = 3
        }
    }
    
    lazy var handle: (Error) -> Void = { [unowned self] (error) in
        //Handles errors NOT from Foursquare API. Mainly IOS errors.
        if let urlError = error as? URLError, urlError.code == URLError.Code.notConnectedToInternet{
            self.searchView.mapView.dodo.error("No internet connection!")
            self.searchView.mapView.dodo.style.bar.hideAfterDelaySeconds = 3
        }
    }
    
    private func setContentView() {
        view.addSubview(searchView)
        searchView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        searchView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true
        searchView.venueSearchBar.delegate = self
        searchView.locationSearchBar.delegate = self
        searchView.locationSearchBar.backgroundColor = .white
        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
    }
    
    private func setNavBar() {
        //        Add search bar
        navigationItem.titleView = searchView.venueSearchBar
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        
        //        Add right bar button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "??", style: .plain, target: self, action: #selector(showResultsVC))
    }
    
    @objc func showResultsVC() {
        let newVC = ResultsVC(results: venuesWithImages)
        navigationController?.pushViewController(newVC, animated: true)
    }
    
}

extension SearchVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var venue: String?
        var locationName: String?
        var userLocation: CLLocationCoordinate2D?
        
//        if CLLocationManager.locationServicesEnabled() {
//
//        } else {
//
//        }
        
        if (searchView.venueSearchBar.text?.isEmpty)! {
            self.searchView.mapView.dodo.style.bar.hideAfterDelaySeconds = 3
            self.searchView.mapView.dodo.info("Please enter a venue.")
            venue = nil
        } else {
            venue = searchView.venueSearchBar.text
        }
        
        if (searchView.locationSearchBar.text?.isEmpty)! {
            locationName = "Chicago, IL"
        } else {
            locationName = searchView.locationSearchBar.text
        }
        
        let venueEndpoint = VenueEndpoint(query: venue, locationName: locationName, userLocation: nil, currentDate: nil)
        VenueSearchAPIClientWithAlamo.manager.getSearchResults(from: venueEndpoint, completionHandler: completion, errorHandler: handle)
        
        
    }
}

extension SearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 140)
    }
}

extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults?.response.venues?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VenueCell", for: indexPath) as! VenueCell
        let index = indexPath.item
        guard var venue = searchResults?.response.venues?[index] else { return cell }
        
        let completion: (VenuePhotoResults) -> Void = { [unowned self] (results) in
            guard let photo = results.response.photos.items.first else { return }
            let endpoint = "\(photo.purplePrefix)original\(photo.suffix)"
            self.searchResults?.response.venues?[index].photoURL = endpoint
            if let image = ImageCache.manager.cachedImage(url: URL(string: (self.searchResults?.response.venues?[index].photoURL!)!)!) {
                cell.venueImageView.image = image
            } else {
                ImageCache.manager.processImageInBackground(imageURL: URL(string: (self.searchResults?.response.venues?[index].photoURL!)!)!,
                                                            completion: {(error, image) in
                                                                cell.venueImageView.image = image; cell.setNeedsLayout()})
            }
        }
        
        let photoEndpoint = VenuePhotoAPIClient.manager.photoEndpoint(venue: venue)
        VenuePhotoAPIClient.manager.getVenuePhotos(from: photoEndpoint,
                                                   completionHandler: completion,
                                                   errorHandler: handle)
        return cell
    }
}
