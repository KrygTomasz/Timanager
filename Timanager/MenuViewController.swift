//
//  MenuViewController.swift
//  Timanager
//
//  Created by Kryg Tomasz on 08.07.2017.
//  Copyright © 2017 Kryg Tomek. All rights reserved.
//

import UIKit

class MenuViewController: MainViewController {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(R.nib.menuCVCell(), forCellWithReuseIdentifier: R.reuseIdentifier.menuCVCell.identifier)
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    @IBOutlet weak var activityView: UIView! {
        didSet {
            activityView.layer.cornerRadius = 10.0
            activityView.backgroundColor = .gray
            ViewTool.addShadow(to: activityView)
        }
    }
    @IBOutlet weak var currentActivityLabel: UILabel! {
        didSet {
            currentActivityLabel.textColor = .white
        }
    }
    @IBOutlet weak var timeLabel: UILabel! {
        didSet {
            timeLabel.textColor = .white
        }
    }
    @IBOutlet weak var chooseActivityButton: UIButton! {
        didSet {
            chooseActivityButton.setTitle(R.string.localizable.chooseActivity(), for: .normal)
            chooseActivityButton.layer.cornerRadius = 10.0
            chooseActivityButton.backgroundColor = UIColor.black
            chooseActivityButton.setTitleColor(.white, for: .normal)
            chooseActivityButton.addTarget(self, action: #selector(onChooseActivityButtonClicked), for: .touchUpInside)
        }
    }
    @IBOutlet weak var startButton: UIButton! {
        didSet {
            startButton.setTitle(R.string.localizable.start(), for: .normal)
            startButton.layer.cornerRadius = 10.0
            startButton.backgroundColor = UIColor.mainDarkGreen
            startButton.setTitleColor(.white, for: .normal)
//            ViewTool.addShadow(to: startButton)
        }
    }
    @IBOutlet weak var stopButton: UIButton! {
        didSet {
            stopButton.setTitle(R.string.localizable.stop(), for: .normal)
            stopButton.layer.cornerRadius = 10.0
            stopButton.backgroundColor = UIColor.mainDarkRed
            stopButton.setTitleColor(.white, for: .normal)
//            ViewTool.addShadow(to: stopButton)
        }
    }
    
    let NUMBER_OF_CELLS: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewTool.addGradientBackground(to: self.view, using: [UIColor.darkGray.cgColor, UIColor.white.cgColor])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    func onChooseActivityButtonClicked() {
        let storyboard = R.storyboard.main()
        guard let vc = storyboard.instantiateViewController(withIdentifier: MenuIdentifiers.ChooseActivityVC) as? ChooseActivityViewController else {
            return
        }
        vc.prepare(using: .black)
        let navController = UINavigationController(rootViewController: vc)

        present(navController, animated: true, completion: nil)
    }

}

// MARK: CollectionView Delegates
extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(NUMBER_OF_CELLS)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.menuCVCell.identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let menuCell = cell as? MenuCVCell else {
            return
        }
        let data = MenuCVCellData(forIndexPath: indexPath)
        menuCell.prepare(with: data)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
       let data = MenuCVCellData(forIndexPath: indexPath)
        switch indexPath.row {
        case 0:
            pushTimeManagerVC(usingColor: data.color)
        case 1:
            pushActivityManagerVC(usingColor: data.color)
        case 2:
            pushSettingsVC(usingColor: data.color)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let menuCell = collectionView.cellForItem(at: indexPath) as? MenuCVCell else {
            return
        }
        ViewTool.removeShadow(from: menuCell.container)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let menuCell = collectionView.cellForItem(at: indexPath) as? MenuCVCell else {
            return
        }
        ViewTool.addShadow(to: menuCell.container)
    }
    
}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width/1
        let cellHeight = collectionView.bounds.height/NUMBER_OF_CELLS
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

//MARK: Pushed ViewControllers
extension MenuViewController {
    
    func pushTimeManagerVC(usingColor color: UIColor?) {
        let storyboard = R.storyboard.statisticsStoryboard()
        guard let vc = storyboard.instantiateViewController(withIdentifier: StatisticsIdentifiers.StatisticsVC) as? StatisticsViewController else {
            return
        }
        vc.prepare(using: color)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushActivityManagerVC(usingColor color: UIColor?) {
        let storyboard = R.storyboard.activityManagerStoryboard()
        guard let vc = storyboard.instantiateViewController(withIdentifier: ActivityManagerIdentifiers.ActivityManagerVC) as? ActivityManagerViewController else {
            return
        }
        vc.prepare(using: color)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushSettingsVC(usingColor color: UIColor?) {
        let storyboard = R.storyboard.settingsStoryboard()
        guard let vc = storyboard.instantiateViewController(withIdentifier: SettingsIdentifiers.SettingsVC) as? SettingsViewController else {
            return
        }
        vc.prepare(using: color)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
