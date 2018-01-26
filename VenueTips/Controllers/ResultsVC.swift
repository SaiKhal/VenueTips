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
    var venuesWithImages = [VenueWithImages]()
    
    
    init(results: [VenueWithImages]) {
        venuesWithImages = results
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
    

}

extension ResultsVC: UITableViewDelegate {
    
}

extension ResultsVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venuesWithImages.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let index = indexPath.row
        let venue = venuesWithImages[index].venue
        cell.textLabel?.text = venue.name
        if let image = ImageCache.manager.cachedImage(url: URL(string: venuesWithImages[index].imageURL)!) {
            cell.imageView?.image = image
        } else {
            ImageCache.manager.processImageInBackground(imageURL: URL(string: venue.photoURL!)!,
                                                        completion: {(error, image) in
                                                            cell.imageView?.image = image; cell.setNeedsLayout()})
        }
        return cell
    }
}


