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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(creationView)
        // Do any additional setup after loading the view.
        creationView.dismissVCButton.addTarget(self, action: #selector(dismissModalVC), for: .touchUpInside)
        creationView.creationButton.addTarget(self, action: #selector(create), for: .touchUpInside)
    }
    
    @objc func create() {
        print("Create collection")
    }
    
    @objc func dismissModalVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
