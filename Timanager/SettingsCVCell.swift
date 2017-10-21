//
//  SettingsCVCell.swift
//  Timanager
//
//  Created by Kryg Tomasz on 02.10.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit

class SettingsCVCell: UICollectionViewCell {

    @IBOutlet weak var container: UIView! {
        didSet {
            container.backgroundColor = .clear
            container.layer.borderColor = UIColor.white.cgColor
            container.layer.borderWidth = 1.0
            container.layer.cornerRadius = 8.0
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .white
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func prepare(using title: String) {
        titleLabel.text = title
    }

}
