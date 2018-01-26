//
//  TipCreationVC.swift
//  VenueTips
//
//  Created by C4Q on 1/23/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

class TipCreationVC: UIViewController {
    
    
    let cellSpacing: CGFloat = 1.0
    let edgeSpacing: CGFloat = 10.0
    let creationView = OtherCreationView()
    var newTip: String! {
        didSet{
            PersistantManager.Manager.addVenue(newVenue: self.venue, and: self.image, collectionName: self.selectedTitle, tip: newTip)
            
            creationView.customView.collectionView.reloadData()
            showSavedAlert()
        }
    }
    var venue: Venue
    var image: UIImage
    var newTitle: String? {
        didSet {
            print("add newTitle: \(newTitle)")
            // Add new cell to the main collections
            PersistantManager.Manager.addNewCollection(newName: newTitle ?? "NO title here")
        
        }
    }
    var selectedTitle: String! {
        didSet {
            guard creationView.textView.text != nil, creationView.textView.text != "" else {
                showTipAlert()
                return
            }
            self.newTip = creationView.textView.text
        }
    }
        
    
    init(venue: Venue, image: UIImage) {
        self.venue = venue
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatal error: fail to initialize TipCreationVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(creationView)
        // Do any additional setup after loading the view.
        creationView.dismissVCButton.addTarget(self, action: #selector(dismissModalVC), for: .touchUpInside)
        creationView.creationButton.addTarget(self, action: #selector(create), for: .touchUpInside)
        
        creationView.textField.delegate = self
     
        creationView.customView.collectionView.delegate = self
         creationView.customView.collectionView.dataSource = self
        
        
    }
    // create new collection:
    @objc func create() {
      
        print("Create collection")
        guard creationView.textField.text != nil, creationView.textField.text != "" else {
            showAlert()
            return
        }
        newTitle = creationView.textField.text!
        
        
        
        
       // self.dismiss(animated: true, completion: nil)
    }
    // dismiss VC
    @objc func dismissModalVC() {
        self.dismiss(animated: true, completion: nil)
    }
    // add tip with selected venue
//    @objc func addTip() {
//        guard creationView.textView.text != nil, creationView.textView.text != "" else {
//            showTipAlert()
//            return
//        }
//        self.newTip = creationView.textView.text
//
//    }
    func showSavedAlert() {
        let alert = UIAlertController(title: "Saved to collection", message: "The new venue has been saved to collections ", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    func showTipAlert() {
        let alert = UIAlertController(title: "Please enter a tip", message: "Please enter a tip for your new venue. ", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    func showAlert() {
        let alert = UIAlertController(title: "Please enter a name", message: "Please enter a name for your new venue collection. ", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
extension TipCreationVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.text != nil, textField.text != "" else {
            showAlert()
            return false
        }
        textField.resignFirstResponder()
        self.newTitle = textField.text
        return true
    }
}



//TODO: handle the collectionView
extension TipCreationVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PersistantManager.Manager.getCollections().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "venueCellWithAdd", for: indexPath) as! VenueCellWithAdd
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        let names = PersistantManager.Manager.getCollections()
        cell.textLabel.text = names[indexPath.row]
        
        
        //cell.addButton.addTarget(self, action: #selector(addTip), for: .touchUpInside)
        
        cell.imageView.image = self.image
        guard !PersistantManager.Manager.getCollections().isEmpty, PersistantManager.Manager.getVenues()[names[indexPath.row]]  != nil else { return cell }
        let lastAddedVenue = PersistantManager.Manager.getVenues()[names[indexPath.row]]!.last!.0
        
        cell.imageView.image = PersistantManager.Manager.getImage(venue: lastAddedVenue)
        return cell
    }
    
    
}
extension TipCreationVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedTitle = PersistantManager.Manager.getCollections()[indexPath.row]
    }
}

extension TipCreationVC: UICollectionViewDelegateFlowLayout {
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

//extension TipCreationVC: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return PersistantManager.Manager.getCollections().count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "venueCellWithAdd", for: indexPath) as! VenueCellWithAdd
//        cell.backgroundColor = .white
//        cell.layer.cornerRadius = 10
//        let names = PersistantManager.Manager.getCollections()
//        cell.textLabel.text = names[indexPath.row]
//
//        //TODO: cell's image
//        let lastAddedVenue = PersistantManager.Manager.getVenues()[names[indexPath.row]]!.last!.0
//
//        cell.imageView.image = PersistantManager.Manager.getImage(venue: lastAddedVenue)
//        return cell
//    }
//
//
//}

