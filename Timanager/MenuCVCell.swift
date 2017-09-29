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
            image = R.image.activity()
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
//            container.layer.cornerRadius = 10.0
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .white
        }
    }
    @IBOutlet weak var titleImageView: UIImageView! {
        didSet {
//            titleImageView.heroID = "navigationImageView"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var bottomView: UIView!
    
    func prepare(with data: MenuCVCellData) {
        
        bottomView.heroID = "navigation"
        titleLabel.heroID = "navigationTitle"
        
        bottomView.backgroundColor = data.color
        titleLabel.text = data.title
        titleLabel.textColor = .white
        prepareImage(data.image, color: data.color)
        container.backgroundColor = .clear
        prepareContainer()
        
    }
    
    func resetHeroIds() {
        bottomView.heroID = nil
        titleLabel.heroID = nil
        titleImageView.heroID = nil
    }
    
    fileprivate func prepareImage(_ image: UIImage?, color: UIColor?) {
        titleImageView.image = image
        titleImageView.image = titleImageView.image?.withRenderingMode(.alwaysTemplate)
        titleImageView.tintColor = .white
    }
    
    fileprivate func prepareContainer() {
        layoutIfNeeded()
//        bottomView.layer.cornerRadius = 16
//        container.layer.cornerRadius = 16//container.bounds.height/2
//        container.roundCornersWithLayerMask(cornerRadii: container.bounds.height/2, corners: [.bottomLeft, .topLeft])
    }

}
