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

    @IBOutlet var containerView: UIView! {
        didSet {
            containerView.heroID = "navigation"
            containerView.backgroundColor = self.color
        }
    }
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
            navigationLabel.heroID = "navigationTitle"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.setGradientBackground()
    }
    
    func onCloseButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }

}
