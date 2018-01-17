//
//  SearchVC.swift
//  VenueTips
//
//  Created by Masai Young on 1/16/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    let searchView = SearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setContentView()
        setNavBar()
    }
    
    private func setContentView() {
        view.addSubview(searchView)
    }
    
    private func setNavBar() {
        //        Add search bar
        let navSearchBar = UISearchBar()
        navSearchBar.searchBarStyle = .prominent
        navSearchBar.isTranslucent = false
        navSearchBar.backgroundColor = .white
        navSearchBar.tag = 0
        navSearchBar.delegate = self
        navSearchBar.placeholder = "Search for a venue"
        navigationItem.titleView = navSearchBar
        
        
        //        Add right bar button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Test", style: .plain, target: self, action: #selector(nextViewController))
    }
    
    
    
    @objc func nextViewController() {
        let newVC = SearchVC()
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
