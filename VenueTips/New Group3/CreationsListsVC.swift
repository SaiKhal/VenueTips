//
//  CreationsListsVC.swift
//  VenueTips
//
//  Created by Masai Young on 1/26/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

class CollecionsListsVC: UIViewController {
    
    
    let resultsView = ResultsView()
    
    var collectionTitle: String!
    
    init(collectionTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.collectionTitle = collectionTitle
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(aDecoder) doesn't exist")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(resultsView)
        setNavBar()
        setTableView()
    }
    
    private func setNavBar() {
        navigationItem.title = "Saved Venues"
    }
    
    private func setTableView() {
        resultsView.tableView.delegate = self
        resultsView.tableView.dataSource = self
    }
    
    
}
//TODO:
extension CollecionsListsVC: UITableViewDelegate {
    
}

extension CollecionsListsVC: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersistantManager.manager.getVenues()[collectionTitle]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let venue = PersistantManager.manager.getVenues()[collectionTitle]![indexPath.row]
        
        cell.textLabel?.text = venue.name
        cell.imageView?.image = PersistantManager.manager.getImage(venue: venue)
        return cell
    }
    
    
    
}
