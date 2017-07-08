//
//  MainViewController.swift
//  Timanager
//
//  Created by Kryg Tomasz on 08.07.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    fileprivate var color: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = color

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepare(using color: UIColor?) {
        self.color = color
    }

}
