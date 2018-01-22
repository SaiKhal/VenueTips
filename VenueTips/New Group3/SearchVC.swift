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
        searchView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        searchView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true
        searchView.venueSearchBar.delegate = self
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
        return CGSize(width: 200, height: 200)
    }
}

extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VenueCell", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
}
