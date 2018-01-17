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
    let cellSpacing: CGFloat = 1.0
    let edgeSpacing: CGFloat = 10.0

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
        present(CreationVC(), animated: true, completion: nil)
    }

}

extension CollectionsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 2
        let numSpaces: CGFloat = numCells + 1
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: (screenWidth - (cellSpacing + edgeSpacing * numSpaces)) / numCells, height: (screenWidth - (cellSpacing * numSpaces)) / numCells)
    }
    //Layout - Inset for section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: edgeSpacing, left: edgeSpacing, bottom: edgeSpacing, right: edgeSpacing)
    }
    //Layout - line spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing + 5
    }
    //Layout - inter item spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}

extension CollectionsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionsCell", for: indexPath)
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        return cell
    }
    
    
}

