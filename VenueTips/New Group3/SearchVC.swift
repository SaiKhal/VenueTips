//
//  SearchVC.swift
//  VenueTips
//
//  Created by Masai Young on 1/16/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit
import Alamofire

class SearchVC: UIViewController {
    
    let searchView = SearchView()
    var searchResults: VenueSearchResults?
    var photoResults: VenuePhotoResults?
    
    func blah() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setContentView()
        setNavBar()
        let endpoint = VenueSearchAPIClient.manager.searchEndpointWithNear(near: "Chicago,IL", query: "tacos")
        
        VenueSearchAPIClientWithAlamo.manager.getSearchResults(from: endpoint,
                                                               completionHandler: { self.searchResults = $0; self.searchView.collectionView.reloadData()}, errorHandler: {print($0)})
        
//        VenueSearchAPIClient.manager.getSearchResults(from: endpoint,
//                                                      completionHandler: { self.searchResults = $0; self.searchView.collectionView.reloadData()},
//                                                      errorHandler: {print($0)})
    }
    
    private func setContentView() {
        view.addSubview(searchView)
        searchView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        searchView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true
        searchView.venueSearchBar.delegate = self
        searchView.locationSearchBar.delegate = self
        searchView.locationSearchBar.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = true
        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
    }
    
    private func setNavBar() {
        //        Add search bar
        let mainCustomSB = MainCustomSearchBar()
        navigationItem.titleView = mainCustomSB
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white

        mainCustomSB.delegate = self
        
        //        Add right bar button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "??", style: .plain, target: self, action: #selector(showResultsVC))
        
    }
    
    @objc func showResultsVC() {
        let newVC = ResultsVC()
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
}

extension SearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 140)
    }
}

extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults?.response.venues.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VenueCell", for: indexPath) as! VenueCell
        let index = indexPath.item
        guard let venue = searchResults?.response.venues[index] else { return cell }
        cell.backgroundColor = .orange
        if Int(venue.name.count) > 15 {
            cell.backgroundColor = .blue
        }
        
        
        let completion: (VenuePhotoResults) -> Void = { (results) in
            guard let photo = results.response.photos.items.first else { return }
            let endpoint = "\(photo.purplePrefix)original\(photo.suffix)"
            ImageDownloader.manager.getImage(from: endpoint,
                                             completionHandler: {cell.venueImageView.image = $0; cell.setNeedsLayout()},
                                             errorHandler: {print($0)})

        }
        
        let photoEndpoint = VenuePhotoAPIClient.manager.photoEndpoint(venue: venue)
        VenuePhotoAPIClient.manager.getVenuePhotos(from: photoEndpoint,
                                                   completionHandler: completion,
                                                   errorHandler: {print($0)})
        return cell
    }
}
