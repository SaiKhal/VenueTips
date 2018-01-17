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
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}
