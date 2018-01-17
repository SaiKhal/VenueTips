//
//  CollectionsVC.swift
//  VenueTips
//
//  Created by Masai Young on 1/16/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

class CollectionsVC: UIViewController {
    
    let collectionsView = CollectionsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionsView)
        // Do any additional setup after loading the view.
        
        collectionsView.collectionView.delegate = self
        collectionsView.collectionView.dataSource = self
        
        navigationItem.title = "Collections"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(nextViewController))
    }
    
    @objc func nextViewController() {
//        present(SearchVC(), animated: true, completion: nil)
    }

}

extension CollectionsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}

extension CollectionsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionsCell", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
    
    
}

