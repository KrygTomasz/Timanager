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

    @IBOutlet weak var navigationView: UIView! {
        didSet {
            navigationView.backgroundColor = self.color
        }
    }
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.setTitle("", for: .normal)
            closeButton.setImage(#imageLiteral(resourceName: "down"), for: .normal)
            closeButton.tintColor = .white
            closeButton.scaleImage(height: 24, width: 24)
            closeButton.backgroundColor = .clear
            closeButton.addTarget(self, action: #selector(onCloseButtonClicked), for: .touchUpInside)
        }
    }
    @IBOutlet weak var navigationLabel: UILabel! {
        didSet {
            navigationLabel.heroID = "navigation"
            navigationLabel.textColor = .white
            navigationLabel.text = R.string.localizable.settings()
        }
    }
    @IBOutlet weak var navigationImageView: UIImageView! {
        didSet {
            navigationImageView.heroID = "navigationImageView"
            navigationImageView.image = #imageLiteral(resourceName: "settings")
            navigationImageView.image = navigationImageView.image?.withRenderingMode(.alwaysTemplate)
            navigationImageView.tintColor = .white
            
        }
    }
    
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
    
    func onCloseButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }

}
