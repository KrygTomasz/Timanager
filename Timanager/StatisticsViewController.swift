//
//  StatisticsViewController.swift
//  Timanager
//
//  Created by Kryg Tomasz on 08.07.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit

class StatisticsViewController: MainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func initNavigationBar() {
        self.navigationItem.title = R.string.localizable.statistics()
    }

}
