//
//  MenuCVCell.swift
//  Timanager
//
//  Created by Kryg Tomasz on 08.07.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit

struct MenuCVCellData {
    init(forIndexPath indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            title = R.string.localizable.statistics()
            image = R.image.pieChart()
            color = .mainYellow
        case 1:
            title = R.string.localizable.manageActivities()
            image = R.image.time()
            color = .mainRed
        case 2:
            title = R.string.localizable.settings()
            image = R.image.settings()
            color = .mainBlue
        case 3:
            title = R.string.localizable.aboutApp()
            image = R.image.info()
            color = .mainGreen
        default:
            break
        }
    }
    
    var title: String = ""
    var image: UIImage?
    var color: UIColor?
}

class MenuCVCell: UICollectionViewCell {

    @IBOutlet weak var container: UIView! {
        didSet {
            container.layer.cornerRadius = 10.0
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .white
        }
    }
    @IBOutlet weak var titleImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func prepare(with data: MenuCVCellData) {
        titleLabel.text = data.title
        prepareImage(data.image)
        container.backgroundColor = data.color
        ViewTool.addShadow(to: container)
    }
    
    func prepareImage(_ image: UIImage?) {
        titleImageView.image = image
        titleImageView.image = titleImageView.image?.withRenderingMode(.alwaysTemplate)
        titleImageView.tintColor = .white
    }

}
