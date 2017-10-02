//
//  SettingsCVCell.swift
//  Timanager
//
//  Created by Kryg Tomasz on 02.10.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit

class SettingsCVCell: UICollectionViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func prepare(using title: String) {
        titleLabel.text = title
    }

}
