//
//  CreateCollectionVC.swift
//  VenueTips
//
//  Created by Masai Young on 1/16/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

class CreationVC: UIViewController {

    let creationView = CreationView()
    var newTitle: String! {
        didSet {
            print("add newTitle: \(newTitle)")
            // Add new cell to the main collections
           PersistantManager.Manager.addNewCollection(newName: newTitle)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(creationView)
        // Do any additional setup after loading the view.
        creationView.dismissVCButton.addTarget(self, action: #selector(dismissModalVC), for: .touchUpInside)
        creationView.creationButton.addTarget(self, action: #selector(create), for: .touchUpInside)
        
        creationView.textField.delegate = self
    }
    
    @objc func create() {
        
        print("Create collection")
        guard creationView.textField.text != nil, creationView.textField.text != "" else {
            showAlert()
            return
        }
        newTitle = creationView.textField.text!
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissModalVC() {
   
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Please enter a name", message: "The text field can not be empty, please enter a name for your new venue collection. ", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
extension CreationVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        guard textField.text != nil, textField.text != "" else {
//            showAlert()
//            return false
//        }
        textField.resignFirstResponder()
       // self.newTitle = textField.text
        return true
    }
    
}
