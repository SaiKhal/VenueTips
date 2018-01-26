//
//  ResultsVC.swift
//  VenueTips
//
//  Created by Masai Young on 1/17/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

class ResultsVC: UIViewController {
    
    let resultsView = ResultsView()
    var searchResults: VenueSearchResults?
    
    init(results: VenueSearchResults?) {
        searchResults = results
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("coder not supported!")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(resultsView)
        setNavBar()
        setTableView()
    }
    
    private func setNavBar() {
        navigationItem.title = "Results"
    }
    
    private func setTableView() {
        resultsView.tableView.delegate = self
        resultsView.tableView.dataSource = self
    }
    
    lazy var handle: (Error) -> Void = { [unowned self] (error) in
        //Handles errors NOT from Foursquare API. Mainly IOS errors.
        if let urlError = error as? URLError, urlError.code == URLError.Code.notConnectedToInternet{
            self.resultsView.tableView.dodo.error("No internet connection!")
            self.resultsView.tableView.dodo.style.bar.hideAfterDelaySeconds = 3
        }
    }

}

extension ResultsVC: UITableViewDelegate {
    
}

extension ResultsVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.response.venues?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let index = indexPath.row
        guard let venue = searchResults?.response.venues?[index] else { return cell }
        
        let completion: (VenuePhotoResults) -> Void = { [unowned self] (results) in
            guard let photo = results.response.photos.items.first else { return }
            let endpoint = "\(photo.purplePrefix)original\(photo.suffix)"
            self.searchResults?.response.venues?[index].photoURL = endpoint
            if let image = ImageCache.manager.cachedImage(url: URL(string: (self.searchResults?.response.venues?[index].photoURL!)!)!) {
                cell.imageView?.image = image
            } else {
                ImageCache.manager.processImageInBackground(imageURL: URL(string: (self.searchResults?.response.venues?[index].photoURL!)!)!,
                                                            completion: {(error, image) in
                                                                cell.imageView?.image = image; cell.setNeedsLayout()})
            }
        }
        
        let photoEndpoint = VenuePhotoAPIClient.manager.photoEndpoint(venue: venue)
        VenuePhotoAPIClient.manager.getVenuePhotos(from: photoEndpoint,
                                                   completionHandler: completion,
                                                   errorHandler: handle)
        cell.textLabel?.text = venue.name
        
        
        return cell
    }
    
    
}


