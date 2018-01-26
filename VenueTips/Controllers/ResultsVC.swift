//
//  ResultsVC.swift
//  VenueTips
//
//  Created by Masai Young on 1/17/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

class ResultsVC: UIViewController {
    
    private let resultsView = ResultsView()
    private var searchResults: VenueSearchResults?
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! ResultsCell
        let venue = searchResults?.response.venues?[indexPath.row]
        let image = selectedCell.venueImageView.image

        let detailVC = VenueDetailVC(venue: venue, photo: image)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ResultsVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchResults?.response.venues == nil {
            tableView.backgroundView = {
                let label = UILabel()
                label.text = "You have no results!"
                label.center = tableView.center
                label.textAlignment = .center
                tableView.separatorStyle = .none
                return label
            }()
            return 0
        } else {
            tableView.backgroundView = nil
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.response.venues?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath) as! ResultsCell
        let index = indexPath.row
        guard let venue = searchResults?.response.venues?[index] else { return cell }
        
        let completion: (VenuePhotoResults) -> Void = { (results) in
            guard let photo = results.response.photos.items.first else { return }
            let endpoint = "\(photo.purplePrefix)original\(photo.suffix)"
            let placeholderImage = UIImage(named: "placeholder-image")
            
            
            cell.venueImageView.kf.indicatorType = .activity
            cell.venueImageView.kf.setImage(with: URL(string: endpoint)!, placeholder: placeholderImage, completionHandler: { (_, _, cacheType, _) in
//                cell.setNeedsLayout()
            })
        }
        
        let photoEndpoint = VenuePhotoAPIClient.manager.photoEndpoint(venue: venue)
        VenuePhotoAPIClient.manager.getVenuePhotos(from: photoEndpoint,
                                                   completionHandler: completion,
                                                   errorHandler: handle)
        cell.venueNameLabel.text = venue.name
        cell.venueAddressLabel.text = venue.location.address ?? "No address"
        return cell
    }
    
    
}


