//
//  ChooseActivityViewController.swift
//  Timanager
//
//  Created by Kryg Tomasz on 09.07.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit

class ChooseActivityViewController: MainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
    }

    func initNavigationBar() {
        let backButton = UIBarButtonItem(title: R.string.localizable.back(), style: .plain, target: self, action: #selector(onBackButtonClicked))
        
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    func onBackButtonClicked() {
        dismiss(animated: true, completion: nil)
    }

}
