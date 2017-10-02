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
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(R.nib.settingsCVCell(), forCellWithReuseIdentifier: R.reuseIdentifier.settingsCVCell.identifier)
            collectionView.delegate = self
            collectionView.dataSource = self
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

// MARK: CollectionView Delegates
extension SettingsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.settingsCVCell.identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let settingsCell = cell as? SettingsCVCell else {
            return
        }
        settingsCell.prepare(using: R.string.localizable.eraseData())
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        switch row {
        case 0:
            showResetDialog()
        default:
            return
        }
    }
    
    func showResetDialog() {
        let alert = UIAlertController(title: R.string.localizable.eraseData(), message: R.string.localizable.eraseDataDescription(), preferredStyle: .actionSheet)
        let acceptAction = UIAlertAction(title: R.string.localizable.yes(), style: .default, handler: {
            action in
            Activity.clear()
            alert.dismiss(animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: R.string.localizable.no(), style: .default, handler: {
            action in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(acceptAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension SettingsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width
        let cellHeight = collectionView.bounds.height/10
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
