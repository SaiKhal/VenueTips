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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(nextViewController))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionsView.collectionView.reloadData()
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
        return PersistantManager.Manager.getCollections().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "otherVenueCell", for: indexPath) as! OtherVenueCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        let names = PersistantManager.Manager.getCollections()
        cell.textLabel.text = names[indexPath.row]
        
        //TODO: cell's image
        let lastAddedVenue = PersistantManager.Manager.getVenues()[names[indexPath.row]]!.last!.0
        
        cell.imageView.image = PersistantManager.Manager.getImage(venue: lastAddedVenue)
        return cell
    }
    
    
}

