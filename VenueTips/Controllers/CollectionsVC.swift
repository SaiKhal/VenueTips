//
//  CollectionsVC.swift
//  VenueTips
//
//  Created by Masai Young on 1/16/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

class CollectionsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Test", style: .done, target: self, action: #selector(nextViewController))
    }
    
    @objc func nextViewController() {
        let newVC = SearchVC()
        newVC.view.backgroundColor = .green
        navigationController?.pushViewController(newVC, animated: true)
    }

}
