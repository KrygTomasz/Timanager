//
//  SettingsViewController.swift
//  Timanager
//
//  Created by Kryg Tomasz on 08.07.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit
import Hero

class SettingsViewController: MainViewController {


    @IBOutlet weak var startButton: UIButton! {
        didSet {
            startButton.heroID = "play"
            startButton.setTitle("", for: .normal)
            startButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            startButton.tintColor = .mainDarkGreen
            startButton.layer.cornerRadius = 10.0
            startButton.backgroundColor = .mainPastelGreen
            startButton.setTitleColor(.white, for: .normal)
            startButton.addShadow()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setGradientBackground()
    }

}
